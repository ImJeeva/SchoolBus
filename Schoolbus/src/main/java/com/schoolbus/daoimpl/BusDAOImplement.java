package com.schoolbus.daoimpl;

import com.schoolbus.dao.BusDAO;
import com.schoolbus.model.Bus;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public class BusDAOImplement implements BusDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void saveBus(Bus bus) {
        sessionFactory.getCurrentSession().save(bus);
    }

    @Override
    public void updateBus(Bus bus) {
        sessionFactory.getCurrentSession().update(bus);
    }

    @Override
    public void deleteBus(int busId) {
        Bus b = getBusById(busId);
        if (b != null) {
            sessionFactory.getCurrentSession().delete(b);
        }
    }

    @Override
    public Bus getBusById(int busId) {
        return sessionFactory.getCurrentSession().get(Bus.class, busId);
    }

    @Override
    public Bus getBusByNumber(String busNumber) {
        List<Bus> results = sessionFactory.getCurrentSession()
                .createQuery("FROM Bus WHERE busNumber = :num", Bus.class)
                .setParameter("num", busNumber)
                .getResultList();
        return results.isEmpty() ? null : results.get(0);
    }

    @Override
    public List<Bus> getAllBuses() {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Bus", Bus.class)
                .getResultList();
    }
}