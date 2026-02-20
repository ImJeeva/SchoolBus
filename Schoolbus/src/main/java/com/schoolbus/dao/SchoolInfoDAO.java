package com.schoolbus.dao;

import com.schoolbus.model.SchoolInfo;

public interface SchoolInfoDAO {
    void saveOrUpdate(SchoolInfo info);
    SchoolInfo getSchoolInfo();  // Returns the single school info record
}