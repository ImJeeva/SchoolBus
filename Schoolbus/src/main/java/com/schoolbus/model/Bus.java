package com.schoolbus.model;

import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "bus")
public class Bus {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "bus_id")
    private int busId;

    @Column(name = "bus_number", unique = true, nullable = false)
    private String busNumber;

    @Column(name = "driver_name", nullable = false)
    private String driverName;

    @Column(name = "driver_phone")
    private String driverPhone;

    @Column(name = "route")
    private String route;

    @Column(name = "capacity")
    private int capacity;

    // One bus can have multiple students
    @OneToMany(mappedBy = "bus", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Student> students;

    // ===== Constructors =====
    public Bus() {}

    // ===== Getters & Setters =====
    public int getBusId()                       { return busId; }
    public void setBusId(int busId)             { this.busId = busId; }

    public String getBusNumber()                { return busNumber; }
    public void setBusNumber(String busNumber)  { this.busNumber = busNumber; }

    public String getDriverName()               { return driverName; }
    public void setDriverName(String d)         { this.driverName = d; }

    public String getDriverPhone()              { return driverPhone; }
    public void setDriverPhone(String p)        { this.driverPhone = p; }

    public String getRoute()                    { return route; }
    public void setRoute(String route)          { this.route = route; }

    public int getCapacity()                    { return capacity; }
    public void setCapacity(int capacity)       { this.capacity = capacity; }

    public List<Student> getStudents()          { return students; }
    public void setStudents(List<Student> s)    { this.students = s; }
}