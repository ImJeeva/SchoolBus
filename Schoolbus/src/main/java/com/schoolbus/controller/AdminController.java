package com.schoolbus.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.schoolbus.dao.AttendaceDAO;
import com.schoolbus.dao.BusDAO;
import com.schoolbus.dao.ParentDAO;
import com.schoolbus.dao.StudentDAO;

import jakarta.servlet.http.HttpSession;


@Controller
public class AdminController {

    @Autowired private StudentDAO   studentDAO;
    @Autowired private ParentDAO    parentDAO;
    @Autowired private BusDAO       busDAO;
    @Autowired private AttendaceDAO attendaceDAO;

    // Hardcoded admin credentials (can move to DB later)
    private static final String ADMIN_USERNAME = "admin";
    private static final String ADMIN_PASSWORD = "admin123";

    // ===== HOME PAGE - redirect to admin login =====
    @GetMapping("/")
    public String home() {
        return "redirect:/admin/login";
    }

    // ===== ADMIN LOGIN =====
    @GetMapping("/admin/login")
    public String showAdminLogin() {
        return "admin-login";
    }

    @PostMapping("/admin/login")
    public String processAdminLogin(@RequestParam("username") String username,
                                    @RequestParam("password") String password,
                                    HttpSession session,
                                    Model model) {
        if (ADMIN_USERNAME.equals(username) && ADMIN_PASSWORD.equals(password)) {
            session.setAttribute("adminLoggedIn", true);
            return "redirect:/admin/dashboard";
        } else {
            model.addAttribute("error", "Invalid admin credentials.");
            return "login";
        }
    }

    // ===== ADMIN DASHBOARD =====
    @GetMapping("/admin/dashboard")
    public String adminDashboard(HttpSession session, Model model) {
        if (session.getAttribute("adminLoggedIn") == null) {
            return "redirect:/admin/login";
        }
        model.addAttribute("totalStudents",   studentDAO.getAllStudents().size());
        model.addAttribute("totalParents",     parentDAO.getAllParents().size());
        model.addAttribute("totalBuses",       busDAO.getAllBuses().size());
        model.addAttribute("recentAttendance", attendaceDAO.getAllAttendance()
                                                           .stream()
                                                           .limit(10)
                                                           .collect(java.util.stream.Collectors.toList()));
        return "admin-dashboard";
    }

    // ===== ADMIN LOGOUT =====
    @GetMapping("/admin/logout")
    public String adminLogout(HttpSession session) {
        session.removeAttribute("adminLoggedIn");
        return "redirect:/admin/login";
    }
}