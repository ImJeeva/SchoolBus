package com.schoolbus.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;

@Entity
@Table(name = "student")
public class Student {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "student_id")
    private int studentId;

    @Column(name = "name", nullable = false)
    private String name;

    // QR Code stores the unique student code (e.g. "STU-001")
    @Column(name = "qr_code", unique = true, nullable = false)
    private String qrCode;

    @Column(name = "class_name")
    private String className;

    @Column(name = "section")
    private String section;

    @Column(name = "photo")
    private String photo;

    // Many students belong to one parent
    @ManyToOne
    @JoinColumn(name = "parent_id")
    private Parent parent;

    // Many students assigned to one bus
    @ManyToOne
    @JoinColumn(name = "bus_id")
    private Bus bus;

    // NOT stored in DB — only used in parent dashboard to show last scan event
    @Transient
    private Attendace lastEvent;

    // ===== Constructors =====
    public Student() {}

    // ===== Getters & Setters =====
    public int getStudentId()                   { return studentId; }
    public void setStudentId(int studentId)     { this.studentId = studentId; }

    public String getName()                     { return name; }
    public void setName(String name)            { this.name = name; }

    public String getQrCode()                   { return qrCode; }
    public void setQrCode(String qrCode)        { this.qrCode = qrCode; }

    public String getClassName()                { return className; }
    public void setClassName(String className)  { this.className = className; }

    public String getSection()                  { return section; }
    public void setSection(String section)      { this.section = section; }

    public String getPhoto()                    { return photo; }
    public void setPhoto(String photo)          { this.photo = photo; }

    public Parent getParent()                   { return parent; }
    public void setParent(Parent parent)        { this.parent = parent; }

    public Bus getBus()                         { return bus; }
    public void setBus(Bus bus)                 { this.bus = bus; }

    public Attendace getLastEvent()             { return lastEvent; }
    public void setLastEvent(Attendace last)    { this.lastEvent = last; }
}