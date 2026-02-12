package com.schoolbus.dao;

import com.schoolbus.model.Parent;
import java.util.List;

public interface ParentDAO {
    void saveParent(Parent parent);
    void updateParent(Parent parent);
    void deleteParent(int parentId);
    Parent getParentById(int parentId);
    Parent getParentByEmail(String email);
    Parent loginParent(String email, String password);
    List<Parent> getAllParents();
}