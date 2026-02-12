package com.schoolbus.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.schoolbus.dao.AttendaceDAO;
import com.schoolbus.dao.ParentDAO;
import com.schoolbus.dao.StudentDAO;
import com.schoolbus.model.Attendace;
import com.schoolbus.model.Parent;
import com.schoolbus.model.Student;

import jakarta.servlet.http.HttpSession;

@Controller
public class ParentController {

    @Autowired private ParentDAO    parentDAO;
    @Autowired private StudentDAO   studentDAO;
    @Autowired private AttendaceDAO attendaceDAO;

    // ===== LOGIN =====
    @GetMapping("/parent/login")
    public String showLoginPage() {
        return "login";
    }

    @PostMapping("/parent/login")
    public String processLogin(@RequestParam("email")    String email,
                               @RequestParam("password") String password,
                               HttpSession session,
                               Model model) {
        Parent parent = parentDAO.loginParent(email, password);
        if (parent != null) {
            session.setAttribute("loggedInParent", parent);
            return "redirect:/parent/dashboard";
        } else {
            model.addAttribute("error", "Invalid email or password. Please try again.");
            return "parent-login";
        }
    }

    // ===== PARENT DASHBOARD =====
    @GetMapping("/parent/dashboard")
    public String parentDashboard(HttpSession session, Model model) {
        Parent parent = (Parent) session.getAttribute("loggedInParent");
        if (parent == null) return "redirect:/parent/login";

        List<Student> children = studentDAO.getStudentsByParentId(parent.getParentId());
        model.addAttribute("parent", parent);
        model.addAttribute("children", children);

        // Get last attendance event for each child
        for (Student child : children) {
            Attendace last = attendaceDAO.getLastEventByStudentId(child.getStudentId());
            child.setLastEvent(last); // We'll add a transient field for this
        }

        return "parent-dashboard";
    }

    // ===== LOGOUT =====
    @GetMapping("/parent/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/parent/login";
    }

    // ===== ADMIN: Manage Parents =====
    @GetMapping("/admin/parent/list")
    public String listParents(Model model) {
        model.addAttribute("parents", parentDAO.getAllParents());
        return "parent-list";
    }

    @GetMapping("/admin/parent/add")
    public String showAddForm(Model model) {
        model.addAttribute("parent", new Parent());
        return "parent-form";
    }

    @PostMapping("/admin/parent/save")
    public String saveParent(@ModelAttribute("parent") Parent parent) {
        parentDAO.saveParent(parent);
        return "redirect:/admin/parent/list";
    }

    @GetMapping("/admin/parent/edit/{id}")
    public String showEditForm(@PathVariable("id") int id, Model model) {
        model.addAttribute("parent", parentDAO.getParentById(id));
        return "parent-form";
    }

    @PostMapping("/admin/parent/update")
    public String updateParent(@ModelAttribute("parent") Parent parent) {
        parentDAO.updateParent(parent);
        return "redirect:/admin/parent/list";
    }

    @GetMapping("/admin/parent/delete/{id}")
    public String deleteParent(@PathVariable("id") int id) {
        parentDAO.deleteParent(id);
        return "redirect:/admin/parent/list";
    }
}