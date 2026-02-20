package com.schoolbus.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.schoolbus.dao.AttendaceDAO;
import com.schoolbus.dao.BusDAO;
import com.schoolbus.dao.StudentDAO;
import com.schoolbus.model.Attendace;
import com.schoolbus.model.Bus;
import com.schoolbus.model.Parent;
import com.schoolbus.model.Student;
import com.schoolbus.service.EmailService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/attendance")
public class AttendenceController {

    @Autowired private AttendaceDAO attendaceDAO;
    @Autowired private StudentDAO   studentDAO;
    @Autowired private BusDAO       busDAO;
    @Autowired private EmailService emailService;   // ← Email instead of SMS

    // ===== DRIVER SCAN PAGE =====
    @GetMapping("/scan-page")
    public String showScanPage(Model model) {
        model.addAttribute("buses", busDAO.getAllBuses());
        return "scan-page";
    }

    // ===== QR SCAN ENDPOINT =====
    // Called when driver scans student QR code on scan page
    @PostMapping("/scan")
    @ResponseBody
    public String processQrScan(@RequestParam("qrCode")    String qrCode,
                                @RequestParam("busId")     int    busId,
                                @RequestParam("eventType") String eventType) {

        // Step 1: Find student by QR code
        Student student = studentDAO.getStudentByQrCode(qrCode);
        if (student == null) {
            return "ERROR: Unknown QR Code - " + qrCode;
        }

        // Step 2: Find bus
        Bus bus = busDAO.getBusById(busId);
        if (bus == null) {
            return "ERROR: Bus not found - " + busId;
        }

        // Step 3: Save attendance record
        Attendace record = new Attendace(student, bus, eventType.toUpperCase(), new Date());
        attendaceDAO.saveAttendance(record);

        // Step 4: Send EMAIL alert to parent
        if (student.getParent() != null && student.getParent().getEmail() != null) {
            String time        = new SimpleDateFormat("hh:mm a").format(new Date());
            String parentEmail = student.getParent().getEmail();  // ← using email now

            if ("BOARDING".equalsIgnoreCase(eventType)) {
                emailService.sendBoardingAlert(parentEmail, student.getName(),
                                               bus.getBusNumber(), time);
            } else if ("DROPOFF".equalsIgnoreCase(eventType)) {
                emailService.sendDropoffAlert(parentEmail, student.getName(),
                                              bus.getBusNumber(), time);
            }

            // Mark alert as sent
            record.setAlertSent(true);
            attendaceDAO.updateAttendance(record);
        }

        // Step 5: Return success response to scan page
        String time = new SimpleDateFormat("hh:mm a").format(new Date());
        return "SUCCESS|" + student.getName() + "|" + eventType + "|" + time;
    }

    // ===== ADMIN: View all attendance =====
    @GetMapping("/list")
    public String listAttendance(Model model) {
        model.addAttribute("attendanceList", attendaceDAO.getAllAttendance());
        return "attendance-list";
    }

    // ===== ADMIN: Filter attendance by date =====
    @GetMapping("/byDate")
    public String attendanceByDate(@RequestParam("date") String dateStr, Model model) {
        try {
            Date date = new SimpleDateFormat("yyyy-MM-dd").parse(dateStr);
            model.addAttribute("attendanceList", attendaceDAO.getAttendanceByDate(date));
            model.addAttribute("selectedDate", dateStr);
        } catch (Exception e) {
            model.addAttribute("error", "Invalid date format.");
        }
        return "attendance-list";
    }

    // ===== PARENT: View child's attendance =====
 // ===== VIEW STUDENT ATTENDANCE (Parent & Admin) =====
    @GetMapping("/student/{studentId}")
    public String viewStudentAttendance(@PathVariable("studentId") int studentId,
                                        HttpSession session,
                                        Model model) {
        Student student = studentDAO.getStudentById(studentId);
        if (student == null) {
            model.addAttribute("error", "Student not found");
            return "redirect:/admin/dashboard";
        }

        List<Attendace> list = attendaceDAO.getAttendanceByStudentId(studentId);
        
        // Check if parent is logged in (for parent portal)
        Parent loggedParent = (Parent) session.getAttribute("loggedParent");
        if (loggedParent != null) {
            // Parent view - verify this is their child
            if (student.getParent() == null || 
                student.getParent().getParentId() != loggedParent.getParentId()) {
                model.addAttribute("error", "Access denied");
                return "redirect:/parent/dashboard";
            }
            model.addAttribute("parent", loggedParent);
            model.addAttribute("student", student);
            model.addAttribute("attendanceList", list);
            return "child-attendance";  // Parent view JSP
        }
        
        // Admin view
        model.addAttribute("student", student);
        model.addAttribute("attendanceList", list);
        return "child-attendance";  // Same JSP works for both
    }
}