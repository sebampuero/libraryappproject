package com.library.service;

import java.util.Arrays;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.library.dao.UserDAO;
import com.library.entity.User;

@Service
public class MyUserDetailsService implements UserDetailsService {

	@Autowired
	private UserDAO userDAO;
	
	@Transactional
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User activeUser = userDAO.findByUsername(username);
		if(activeUser == null)
			throw new UsernameNotFoundException("User does not exist");
		GrantedAuthority authority = new SimpleGrantedAuthority(activeUser.getRole());
		UserDetails userDetails = (UserDetails)new org.springframework.security.core.userdetails.User(activeUser.getUserName(), 
				activeUser.getPassword(), Arrays.asList(authority));
		return userDetails;
	}

}
