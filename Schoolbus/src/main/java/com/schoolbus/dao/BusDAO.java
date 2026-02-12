package com.schoolbus.dao;

import com.schoolbus.model.Bus;
import java.util.List;

public interface BusDAO {
    void saveBus(Bus bus);
    void updateBus(Bus bus);
    void deleteBus(int busId);
    Bus getBusById(int busId);
    Bus getBusByNumber(String busNumber);
    List<Bus> getAllBuses();
}