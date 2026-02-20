package com.schoolbus.daoimpl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.schoolbus.dao.AttendaceDAO;
import com.schoolbus.model.Attendace;

@Repository
@Transactional
public class AttendaceDAOImplement implements AttendaceDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void saveAttendance(Attendace attendace) {
        sessionFactory.getCurrentSession().save(attendace);
    }

    @Override
    public void updateAttendance(Attendace attendace) {
        sessionFactory.getCurrentSession().update(attendace);
    }

    @Override
    public List<Attendace> getAllAttendance() {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Attendace ORDER BY scanTime DESC", Attendace.class)
                .getResultList();
    }

    @Override
    public List<Attendace> getAttendanceByStudentIds(List<Integer> studentIds) {
        if (studentIds == null || studentIds.isEmpty()) {
            return new ArrayList<>();
        }
        
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Attendace WHERE student.studentId IN :ids ORDER BY scanTime DESC", Attendace.class)
                .setParameterList("ids", studentIds)
                .getResultList();
    }
    @Override
    public List<Attendace> getAttendanceByStudentId(int studentId) {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Attendace WHERE student.studentId = :sid ORDER BY scanTime DESC", Attendace.class)
                .setParameter("sid", studentId)
                .getResultList();
    }

    @Override
    public List<Attendace> getAttendanceByBusId(int busId) {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Attendace WHERE bus.busId = :bid ORDER BY scanTime DESC", Attendace.class)
                .setParameter("bid", busId)
                .getResultList();
    }

    @Override
    public List<Attendace> getAttendanceByDate(Date date) {
        // Get start and end of the given day
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        Date startOfDay = cal.getTime();

        cal.set(Calendar.HOUR_OF_DAY, 23);
        cal.set(Calendar.MINUTE, 59);
        cal.set(Calendar.SECOND, 59);
        Date endOfDay = cal.getTime();

        return sessionFactory.getCurrentSession()
                .createQuery("FROM Attendace WHERE scanTime BETWEEN :start AND :end ORDER BY scanTime DESC", Attendace.class)
                .setParameter("start", startOfDay)
                .setParameter("end", endOfDay)
                .getResultList();
    }

    @Override
    public Attendace getLastEventByStudentId(int studentId) {
        List<Attendace> results = sessionFactory.getCurrentSession()
                .createQuery("FROM Attendace WHERE student.studentId = :sid ORDER BY scanTime DESC", Attendace.class)
                .setParameter("sid", studentId)
                .setMaxResults(1)
                .getResultList();
        return results.isEmpty() ? null : results.get(0);
    }
}