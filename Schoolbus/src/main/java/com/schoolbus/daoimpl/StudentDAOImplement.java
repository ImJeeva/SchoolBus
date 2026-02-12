package com.schoolbus.daoimpl;

import com.schoolbus.dao.StudentDAO;
import com.schoolbus.model.Student;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class StudentDAOImplement implements StudentDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void saveStudent(Student student) {
        sessionFactory.getCurrentSession().save(student);
    }

    @Override
    public void updateStudent(Student student) {
        sessionFactory.getCurrentSession().update(student);
    }

    @Override
    public void deleteStudent(int studentId) {
        Student s = getStudentById(studentId);
        if (s != null) {
            sessionFactory.getCurrentSession().delete(s);
        }
    }

    @Override
    public Student getStudentById(int studentId) {
        return sessionFactory.getCurrentSession().get(Student.class, studentId);
    }

    // Called when driver scans QR code — finds student by their unique QR code value
    @Override
    public Student getStudentByQrCode(String qrCode) {
        List<Student> results = sessionFactory.getCurrentSession()
                .createQuery("FROM Student WHERE qrCode = :qr", Student.class)
                .setParameter("qr", qrCode)
                .getResultList();
        return results.isEmpty() ? null : results.get(0);
    }

    @Override
    public List<Student> getAllStudents() {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Student", Student.class)
                .getResultList();
    }

    @Override
    public List<Student> getStudentsByParentId(int parentId) {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Student WHERE parent.parentId = :pid", Student.class)
                .setParameter("pid", parentId)
                .getResultList();
    }

    @Override
    public List<Student> getStudentsByBusId(int busId) {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Student WHERE bus.busId = :bid", Student.class)
                .setParameter("bid", busId)
                .getResultList();
    }
}