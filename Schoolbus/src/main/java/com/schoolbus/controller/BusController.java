package com.schoolbus.controller;

import com.schoolbus.dao.BusDAO;
import com.schoolbus.model.Bus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/bus")
public class BusController {

    @Autowired private BusDAO busDAO;

    // List all buses
    @GetMapping("/list")
    public String listBuses(Model model) {
        model.addAttribute("buses", busDAO.getAllBuses());
        return "bus-list";
    }

    // Show add form
    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("bus", new Bus());
        return "bus-form";
    }

    // Save new bus
    @PostMapping("/save")
    public String saveBus(@ModelAttribute("bus") Bus bus) {
        busDAO.saveBus(bus);
        return "redirect:/admin/bus/list";
    }

    // Show edit form
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") int id, Model model) {
        model.addAttribute("bus", busDAO.getBusById(id));
        return "bus-form";
    }

    // Update bus
    @PostMapping("/update")
    public String updateBus(@ModelAttribute("bus") Bus bus) {
        busDAO.updateBus(bus);
        return "redirect:/admin/bus/list";
    }

    // Delete bus
    @GetMapping("/delete/{id}")
    public String deleteBus(@PathVariable("id") int id) {
        busDAO.deleteBus(id);
        return "redirect:/admin/bus/list";
    }
}