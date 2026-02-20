package com.schoolbus.daoimpl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.schoolbus.dao.ParentDAO;
import com.schoolbus.model.Parent;

@Repository
@Transactional
public class ParentDAOImplement implements ParentDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void saveParent(Parent parent) {
        sessionFactory.getCurrentSession().save(parent);
    }

    @Override
    public void updateParent(Parent parent) {
        sessionFactory.getCurrentSession().update(parent);
    }
    
    @Override
    public Parent getParentWithChildren(int parentId) {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Parent p LEFT JOIN FETCH p.students WHERE p.parentId = :pid", Parent.class)
                .setParameter("pid", parentId)
                .uniqueResult();
    }

    @Override
    public void deleteParent(int parentId) {
        Parent p = getParentById(parentId);
        if (p != null) {
            sessionFactory.getCurrentSession().delete(p);
        }
    }

    @Override
    public Parent getParentById(int parentId) {
        return sessionFactory.getCurrentSession().get(Parent.class, parentId);
    }

    @Override
    public Parent getParentByEmail(String email) {
        List<Parent> results = sessionFactory.getCurrentSession()
                .createQuery("FROM Parent WHERE email = :email", Parent.class)
                .setParameter("email", email)
                .getResultList();
        return results.isEmpty() ? null : results.get(0);
    }

    @Override
    public Parent loginParent(String email, String password) {
        List<Parent> results = sessionFactory.getCurrentSession()
                .createQuery("FROM Parent WHERE email = :email AND password = :pwd", Parent.class)
                .setParameter("email", email)
                .setParameter("pwd", password)
                .getResultList();
        return results.isEmpty() ? null : results.get(0);
    }

    @Override
    public List<Parent> getAllParents() {
        Session session = sessionFactory.openSession();
        List<Parent> parents = session.createQuery(
            "SELECT DISTINCT p FROM Parent p LEFT JOIN FETCH p.students",
            Parent.class
        ).getResultList();
        session.close();
        return parents;
    }

}