package com.library.service;

import java.math.BigInteger;
import java.util.List;

import org.springframework.security.access.annotation.Secured;

import com.library.entity.Message;
import com.library.entity.User;

public interface UserService {
	
	
	User findByUsername(String username);
	
//	Boolean checkLogin(String username, String password);

	boolean registerNewUser(User user);

	byte[] retrieveProfilePic(int parseInt);

	void updateUser(User user);
	

	void saveMessage(Message message);


	void setAsReadMessage(int messageId);

	List<User> queryUsers(String query);

	void deleteMessage(int parseInt);

	User findUserByEmail(String email);

	void createPasswordTokenForUser(User user, String token);

	String validatePasswordResetToken(int id, String token);

	void changeUserPassword(User user, String password);

}
