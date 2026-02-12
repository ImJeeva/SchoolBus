package com.schoolbus.model;

import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

@Entity
@Table(name = "attendance")
public class Attendace {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "attendance_id")
    private int attendanceId;

    // Which student scanned
    @ManyToOne
    @JoinColumn(name = "student_id", nullable = false)
    private Student student;

    // Which bus they boarded
    @ManyToOne
    @JoinColumn(name = "bus_id")
    private Bus bus;

    // BOARDING or DROPOFF
    @Column(name = "event_type", nullable = false)
    private String eventType;   // "BOARDING" | "DROPOFF"

    // Date and time of scan
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "scan_time", nullable = false)
    private Date scanTime;

    // SMS alert sent?
    @Column(name = "alert_sent")
    private boolean alertSent;

    // ===== Constructors =====
    public Attendace() {}

    public Attendace(Student student, Bus bus, String eventType, Date scanTime) {
        this.student   = student;
        this.bus       = bus;
        this.eventType = eventType;
        this.scanTime  = scanTime;
        this.alertSent = false;
    }

    // ===== Getters & Setters =====
    public int getAttendanceId()                    { return attendanceId; }
    public void setAttendanceId(int id)             { this.attendanceId = id; }

    public Student getStudent()                     { return student; }
    public void setStudent(Student student)         { this.student = student; }

    public Bus getBus()                             { return bus; }
    public void setBus(Bus bus)                     { this.bus = bus; }

    public String getEventType()                    { return eventType; }
    public void setEventType(String eventType)      { this.eventType = eventType; }

    public Date getScanTime()                       { return scanTime; }
    public void setScanTime(Date scanTime)          { this.scanTime = scanTime; }

    public boolean isAlertSent()                    { return alertSent; }
    public void setAlertSent(boolean alertSent)     { this.alertSent = alertSent; }
}