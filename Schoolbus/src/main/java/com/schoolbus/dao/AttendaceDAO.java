package com.schoolbus.dao;

import com.schoolbus.model.Attendace;
import java.util.Date;
import java.util.List;

public interface AttendaceDAO {
    void saveAttendance(Attendace attendace);
    void updateAttendance(Attendace attendace);
    List<Attendace> getAllAttendance();
    List<Attendace> getAttendanceByStudentId(int studentId);
    List<Attendace> getAttendanceByBusId(int busId);
    List<Attendace> getAttendanceByDate(Date date);
    Attendace getLastEventByStudentId(int studentId);
    List<Attendace> getAttendanceByStudentIds(List<Integer> studentIds);
}