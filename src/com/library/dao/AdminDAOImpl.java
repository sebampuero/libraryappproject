package com.library.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.library.entity.User;

@Repository
public class AdminDAOImpl implements AdminDAO {

	@Autowired
	SessionFactory sessionFactory;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Override
	public List<User> showAdmins() {
		Session session = sessionFactory.getCurrentSession();
		@SuppressWarnings("unchecked")
		List<User> admins = session.createQuery("from User where role like 'ROLE_ADMIN'").getResultList();
		return admins;
	}
	
	
	//consider moving out
	@Override
	public void createNewAdminUser(User user) {
		Session session = sessionFactory.getCurrentSession();
		user.setRole("ROLE_ADMIN");
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		session.save(user);
	}

	@Override
	public List<User> showUsers() {
		Session session = sessionFactory.getCurrentSession();
		@SuppressWarnings("unchecked")
		List<User> users = session.createQuery("from User where role not like 'ROLE_ADMIN'").getResultList();
		return users;
	}


	@Override
	public List<User> searchAdminByName(String adminName) {
		Session session = sessionFactory.getCurrentSession();
		@SuppressWarnings("unchecked")
		List<User> admins = session.createQuery("from User where role like 'ROLE_ADMIN' and name like :adminName").
				setParameter("adminName", "%"+adminName+"%").getResultList();
		return admins;
	}

}
