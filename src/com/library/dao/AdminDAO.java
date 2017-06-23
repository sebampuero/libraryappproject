package com.library.dao;

import java.util.List;

import com.library.entity.User;

public interface AdminDAO {
	
	List<User> showAdmins();

	void createNewAdminUser(User user);

	List<User> showUsers();

	List<User> searchAdminByName(String adminName);

}
