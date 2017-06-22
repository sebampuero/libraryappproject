package com.library.service;

import java.util.List;

import org.springframework.security.access.annotation.Secured;

import com.library.entity.User;

public interface AdminService {
	

	@Secured({"ROLE_ADMIN"})
	List<User> showAdmins();

	@Secured({"ROLE_ADMIN"})
	void createNewAdminUser(User user);
	
	@Secured({"ROLE_ADMIN"})
	List<User> showUsers();

	@Secured({"ROLE_ADMIN"})
	List<User> searchAdminByName(String adminName);
}
