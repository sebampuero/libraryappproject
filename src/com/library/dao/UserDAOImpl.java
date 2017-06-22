package com.library.dao;

import javax.persistence.Query;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

import com.library.entity.Message;
import com.library.entity.PasswordResetToken;
import com.library.entity.User;

@Repository
public class UserDAOImpl implements UserDAO {
	
	@Autowired
	SessionFactory sessionFactory;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	/*
	 * (non-Javadoc) this class is self explanatory
	 * @see com.library.dao.UserDAO#findByUsername(java.lang.String)
	 */
	@Override
	public User findByUsername(String username) {
		User user = null;
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from User where userName like :username").
				setParameter("username", username);
		if(query!=null){
			@SuppressWarnings("unchecked")
			List<User> theUser = query.getResultList();
			if(theUser.size()==0) //if username was not found in db
				throw new IndexOutOfBoundsException("Bad credentials");
			user = theUser.get(0); //get the user
		}
		return user;
	}

	/*
	 * (non-Javadoc) register a new user
	 * @see com.library.dao.UserDAO#registerNewUser(com.library.entity.User)
	 */
	@Override
	public boolean registerNewUser(User user) {
		Session session = sessionFactory.getCurrentSession();
		//Select all the available usernames in the DB
		Query query = session.createQuery("select userName from User");
		@SuppressWarnings("unchecked")
		List<String> usernames = query.getResultList();
		//Check if the user wants to use an already existing username
		//If so, return true as "usernameExists" boolean flag
		for(String s : usernames){
			if(s.equals(user.getUserName())){
				return true; //return true if this username already exists , do not insert the user
			}
		}
		//if the username is free, then save the new user in the DB
		user.setRole("ROLE_USER"); //as per default save users with role user
		user.setPassword(passwordEncoder.encode(user.getPassword())); //encode the password
		session.save(user);
		return false;	
	}
	/*
	 * (non-Javadoc) retrieve the profile pic saved for this user
	 * @see com.library.dao.UserDAO#retrieveProfilePic(int)
	 */
	@Override
	public byte[] retrieveProfilePic(int id) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("select image from User where id = :id").setParameter("id", id);
		byte[] image = (byte[])query.getSingleResult();
		return image;
	}
	/*
	 * (non-Javadoc) edit the user attributes
	 * @see com.library.dao.UserDAO#updateUser(com.library.entity.User)
	 */
	@Override
	public void updateUser(User user) {
		Session session = sessionFactory.getCurrentSession();
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		session.update(user);
	}

	@Override
	public void saveMessage(Message message) {
		Session session = sessionFactory.getCurrentSession();
		session.save(message);
	}

	@Override
	public void setMessageAsRead(int messageId) {
		Session session = sessionFactory.getCurrentSession();
		session.createQuery("update Message set is_read = 1 where message_id=:msg_id").setParameter("msg_id", messageId).executeUpdate();
	}

	@Override
	public List<User> queryUsers(String query) {
		Session session = sessionFactory.getCurrentSession();
		@SuppressWarnings("unchecked")
		List<User> users = session.createQuery("from User where username like :query").setParameter("query", "%"+query+"%").getResultList();
		return users;
	}

	@Override
	public void deleteMessage(int messageId) {
		Session session = sessionFactory.getCurrentSession();
		session.createNativeQuery("delete from message where message_id = :id").setParameter("id", messageId).executeUpdate();
		
	}

	@Override
	public User findUserByEmail(String email) {
		User user = null;
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from User where email like :email").
				setParameter("email", email);
		if(query!=null){
			@SuppressWarnings("unchecked")
			List<User> theUser = query.getResultList();
			if(theUser.size()==0) //if username was not found in db
				throw new IndexOutOfBoundsException("No user found");
			user = theUser.get(0); //get the user
		}
		return user;
	}

	@Override
	public void changeUserPassword(User user, String password) {
		Session session = sessionFactory.getCurrentSession();
		user.setPassword(passwordEncoder.encode(password));
		session.update(user);
	}
	
	//consider moving out
	@Override
	public void createPasswordTokenForUser(User user, String token) {
		Session session = sessionFactory.getCurrentSession();
		PasswordResetToken myToken = new PasswordResetToken();
		myToken.setUser(user);
		myToken.setToken(token);
		myToken.setExpiryDate(myToken.calculateExpiryDate(PasswordResetToken.EXPIRATION));
		session.save(myToken);
	}

	
	//consider moving out
	@Override
	public String validatePasswordResetToken(int id, String token) {
		PasswordResetToken theToken = findByToken(token);
		if((theToken == null) || (theToken.getUser().getId()!=id))
			return "invalidToken";
		Calendar cal = Calendar.getInstance();
		if((theToken.getExpiryDate().getTime() - cal.getTime().getTime() <=0))
			return "expired";
		User user = theToken.getUser();
		Authentication auth = new UsernamePasswordAuthenticationToken(
				user,null,Arrays.asList(new SimpleGrantedAuthority("CHANGE_PASSWORD_PRIVILEGE")));
		SecurityContextHolder.getContext().setAuthentication(auth);
		return null;
	}
	
	//consider moving out
	private PasswordResetToken findByToken(String token) {
		Session session = sessionFactory.getCurrentSession();
		@SuppressWarnings("unchecked")
		List<PasswordResetToken> tokens = session.createQuery("from PasswordResetToken where token like :token").
				setParameter("token", token).getResultList();
		try{
			PasswordResetToken theToken = tokens.get(0);
			return theToken;
		}catch(Exception e){
			return null;
		}
	}

	
	

}
