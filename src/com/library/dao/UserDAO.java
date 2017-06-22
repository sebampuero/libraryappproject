package com.library.dao;

import java.math.BigInteger;
import java.util.List;

import com.library.entity.Message;
import com.library.entity.User;

public interface UserDAO {
	
	User findByUsername(String username);
	
//	Boolean checkLogin(String username, String password);

	boolean registerNewUser(User user);

	byte[] retrieveProfilePic(int id);

	void updateUser(User user);

	void saveMessage(Message message);

	void setMessageAsRead(int messageId);

	List<User> queryUsers(String query);

	void deleteMessage(int messageId);

	User findUserByEmail(String email);

	void createPasswordTokenForUser(User user, String token);

	String validatePasswordResetToken(int id, String token);

	void changeUserPassword(User user, String password);

}
