package com.library.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.library.dao.AdminDAO;
import com.library.entity.User;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDAO adminDAO;
	
	@Transactional
	@Override
	public List<User> showAdmins() {
		return adminDAO.showAdmins();
	}

	@Transactional
	@Override
	public void createNewAdminUser(User user) {
		adminDAO.createNewAdminUser(user);
		
	}

	@Transactional
	@Override
	public List<User> showUsers() {
		return adminDAO.showUsers();
	}

	@Transactional
	@Override
	public List<User> searchAdminByName(String adminName) {
		return adminDAO.searchAdminByName(adminName);
	}

}
