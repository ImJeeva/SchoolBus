package com.schoolbus.controller;

import com.schoolbus.dao.BusDAO;
import com.schoolbus.dao.ParentDAO;
import com.schoolbus.dao.StudentDAO;
import com.schoolbus.model.Student;
import com.schoolbus.service.QRCodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/student")
public class StudentController {

    @Autowired private StudentDAO    studentDAO;
    @Autowired private ParentDAO     parentDAO;
    @Autowired private BusDAO        busDAO;
    @Autowired private QRCodeService qrCodeService;

    // ===== List all students =====
    @GetMapping("/list")
    public String listStudents(Model model) {
        model.addAttribute("students", studentDAO.getAllStudents());
        return "student-list";
    }

    // ===== Show add form =====
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("student", new Student());
        model.addAttribute("parents", parentDAO.getAllParents());
        model.addAttribute("buses",   busDAO.getAllBuses());
        return "student-form";
    }

    // ===== Save new student =====
    @PostMapping("/save")
    public String saveStudent(@ModelAttribute("student") Student student) {

        // FIX: Set a temporary qrCode BEFORE saving
        // so Hibernate does not complain about null qrCode (NOT NULL column)
        student.setQrCode("TEMP");

        // Step 1: Save student — now qrCode = "TEMP", no null error
        studentDAO.saveStudent(student);

        // Step 2: Now we have the real studentId — generate proper QR value
        String realQrCode = qrCodeService.generateQRCodeValue(student.getStudentId());
        student.setQrCode(realQrCode);

        // Step 3: Update student with real QR code (e.g. "STU-5")
        studentDAO.updateStudent(student);

        return "redirect:/admin/student/list";
    }

    // ===== Show edit form =====
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") int id, Model model) {
        model.addAttribute("student", studentDAO.getStudentById(id));
        model.addAttribute("parents", parentDAO.getAllParents());
        model.addAttribute("buses",   busDAO.getAllBuses());
        return "student-form";
    }

    // ===== Update student =====
    @PostMapping("/update")
    public String updateStudent(@ModelAttribute("student") Student student) {
        studentDAO.updateStudent(student);
        return "redirect:/admin/student/list";
    }

    // ===== Delete student =====
    @GetMapping("/delete/{id}")
    public String deleteStudent(@PathVariable("id") int id) {
        studentDAO.deleteStudent(id);
        return "redirect:/admin/student/list";
    }

    // ===== View & Print QR Code =====
    @GetMapping("/qrcode/{id}")
    public String viewQRCode(@PathVariable("id") int id, Model model) {
        Student student  = studentDAO.getStudentById(id);
        String  qrBase64 = qrCodeService.generateQRCodeBase64(student.getQrCode());
        model.addAttribute("student",  student);
        model.addAttribute("qrBase64", qrBase64);
        return "student-qrcode";
    }
}