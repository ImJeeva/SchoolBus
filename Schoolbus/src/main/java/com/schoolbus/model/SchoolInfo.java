package com.schoolbus.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "school_info")
public class SchoolInfo {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "info_id")
    private int infoId;
    
    @Column(name = "school_name", nullable = false, length = 200)
    private String schoolName;
    
    @Column(name = "address", length = 500)
    private String address;
    
    @Column(name = "phone", length = 20)
    private String phone;
    
    @Column(name = "email", length = 100)
    private String email;
    
    @Column(name = "principal_name", length = 100)
    private String principalName;
    
    @Column(name = "school_timings", length = 200)
    private String schoolTimings;
    
    // Constructors
    public SchoolInfo() {}
    
    public SchoolInfo(String schoolName, String address, String phone, String email, 
                      String principalName, String schoolTimings) {
        this.schoolName = schoolName;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.principalName = principalName;
        this.schoolTimings = schoolTimings;
    }
    
    // Getters and Setters
    public int getInfoId() { return infoId; }
    public void setInfoId(int infoId) { this.infoId = infoId; }
    
    public String getSchoolName() { return schoolName; }
    public void setSchoolName(String schoolName) { this.schoolName = schoolName; }
    
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPrincipalName() { return principalName; }
    public void setPrincipalName(String principalName) { this.principalName = principalName; }
    
    public String getSchoolTimings() { return schoolTimings; }
    public void setSchoolTimings(String schoolTimings) { this.schoolTimings = schoolTimings; }
}