package com.library.service;

import java.math.BigInteger;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.library.dao.UserDAO;
import com.library.entity.Message;
import com.library.entity.User;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDAO userDAO;
	
	@Transactional
	@Override
	public User findByUsername(String username) {
		return userDAO.findByUsername(username);
	}

	@Transactional
	@Override
	public boolean registerNewUser(User user) {
		return userDAO.registerNewUser(user);
	}

	@Transactional
	@Override
	public byte[] retrieveProfilePic(int id) {
		return userDAO.retrieveProfilePic(id);
	}

	@Transactional
	@Override
	public void updateUser(User user) {
		userDAO.updateUser(user);
	}


	@Transactional
	@Override
	public void saveMessage(Message message) {
		userDAO.saveMessage(message);
	}

	@Transactional
	@Override
	public void setAsReadMessage(int messageId) {
		userDAO.setMessageAsRead(messageId);
	}

	@Transactional
	@Override
	public List<User> queryUsers(String query) {
		return userDAO.queryUsers(query);
	}

	@Transactional
	@Override
	public void deleteMessage(int messageId) {
		userDAO.deleteMessage(messageId);
	}

	@Transactional
	@Override
	public User findUserByEmail(String email) {
		return userDAO.findUserByEmail(email);
	}

	@Transactional
	@Override
	public void createPasswordTokenForUser(User user, String token) {
		userDAO.createPasswordTokenForUser(user,token);
		
	}

	@Transactional
	@Override
	public String validatePasswordResetToken(int id, String token) {
		return userDAO.validatePasswordResetToken(id,token);
	}

	@Transactional
	@Override
	public void changeUserPassword(User user, String password) {
		userDAO.changeUserPassword(user,password);
	}

}
