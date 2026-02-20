package com.schoolbus.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.schoolbus.dao.SchoolInfoDAO;
import com.schoolbus.model.Parent;
import com.schoolbus.model.SchoolInfo;
import com.schoolbus.service.EmailService;

import jakarta.servlet.http.HttpSession;

@Controller
public class SchoolInfoController {
    
    @Autowired
    private SchoolInfoDAO schoolInfoDAO;
    
    // ===== ADMIN: View/Edit School Info =====
    @GetMapping("/admin/school-info")
    public String adminSchoolInfo(HttpSession session, Model model) {
        if (session.getAttribute("adminLoggedIn") == null) {
            return "redirect:/admin/login";
        }
        
        SchoolInfo info = schoolInfoDAO.getSchoolInfo();
        model.addAttribute("schoolInfo", info);
        return "admin-school-info-form";
    }
    
    @PostMapping("/admin/school-info/save")
    public String saveSchoolInfo(@ModelAttribute SchoolInfo schoolInfo,
                                 HttpSession session,
                                 Model model) {
        if (session.getAttribute("adminLoggedIn") == null) {
            return "redirect:/admin/login";
        }
        
        schoolInfoDAO.saveOrUpdate(schoolInfo);
        model.addAttribute("success", "School information updated successfully!");
        model.addAttribute("schoolInfo", schoolInfo);
        return "admin-school-info-form";
    }
    
    // ===== PARENT: View School Info (Read-only) =====
    @GetMapping("/parent/school-info")
    public String parentSchoolInfo(HttpSession session, Model model) {
        if (session.getAttribute("loggedInParent") == null) {
            return "redirect:/parent/login";
        }
        
        SchoolInfo info = schoolInfoDAO.getSchoolInfo();
        model.addAttribute("parent", session.getAttribute("loggedInParent"));
        model.addAttribute("schoolInfo", info);
        return "parent-school-info-view";
    }
    
    // ===== PARENT: Contact School Page =====
    @GetMapping("/parent/contact")
    public String parentContactPage(HttpSession session, Model model) {
        if (session.getAttribute("loggedInParent") == null) {
            return "redirect:/parent/login";
        }
        
        SchoolInfo info = schoolInfoDAO.getSchoolInfo();
        model.addAttribute("parent", session.getAttribute("loggedInParent"));
        model.addAttribute("schoolInfo", info);
        return "parent-contact-school";
    }
    
    
    @Autowired
    private EmailService emailService;  // Add this at the top with other @Autowired

    // ===== PARENT: Send Contact Message =====
    @PostMapping("/parent/contact/send")
    public String sendContactMessage(@RequestParam("subject") String subject,
                                     @RequestParam("message") String message,
                                     HttpSession session,
                                     Model model) {
        if (session.getAttribute("loggedInParent") == null) {
            return "redirect:/parent/login";
        }
        
        Parent parent = (Parent) session.getAttribute("loggedParent");
        SchoolInfo info = schoolInfoDAO.getSchoolInfo();
        
        // Send email to school
        emailService.sendContactMessage(
            info.getEmail(),           // School email (to)
            parent.getEmail(),         // Parent email (from)
            parent.getName(),          // Parent name
            subject,                   // Subject
            message                    // Message body
        );
        
        model.addAttribute("parent", parent);
        model.addAttribute("schoolInfo", info);
        model.addAttribute("success", "✅ Message sent successfully! The school will respond soon.");
        
        return "parent-contact-school";
    }
}