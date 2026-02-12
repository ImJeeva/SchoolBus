package com.schoolbus.dao;

import com.schoolbus.model.Student;
import java.util.List;

public interface StudentDAO {
    void saveStudent(Student student);
    void updateStudent(Student student);
    void deleteStudent(int studentId);
    Student getStudentById(int studentId);
    Student getStudentByQrCode(String qrCode);      // used when driver scans QR
    List<Student> getAllStudents();
    List<Student> getStudentsByParentId(int parentId);
    List<Student> getStudentsByBusId(int busId);
}