package com.schoolbus.daoimpl;

import com.schoolbus.dao.SchoolInfoDAO;
import com.schoolbus.model.SchoolInfo;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Repository
@Transactional
public class SchoolInfoDAOImplement implements SchoolInfoDAO {
    
    @Autowired
    private SessionFactory sessionFactory;
    
    @Override
    public void saveOrUpdate(SchoolInfo info) {
        sessionFactory.getCurrentSession().saveOrUpdate(info);
    }
    
    @Override
    public SchoolInfo getSchoolInfo() {
        // Get first record (there should only be one)
        List<SchoolInfo> list = sessionFactory.getCurrentSession()
                .createQuery("FROM SchoolInfo", SchoolInfo.class)
                .setMaxResults(1)
                .getResultList();
        
        // If no record exists, create default
        if (list.isEmpty()) {
            SchoolInfo defaultInfo = new SchoolInfo(
                "SmartBus School",
                "123 Education Street, Chennai",
                "+91-9876543210",
                "info@smartbusschool.edu",
                "Dr. Principal Name",
                "8:00 AM - 3:00 PM"
            );
            saveOrUpdate(defaultInfo);
            return defaultInfo;
        }
        
        return list.get(0);
    }
}