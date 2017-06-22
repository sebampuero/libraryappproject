package com.library.entity;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class Registrationform {
	
	@NotNull(message = "Cant be empty")
	private String name;
	@NotNull(message = "Cant be empty")
	private String lastName;
	@NotNull(message = "Cant be empty")
	private String userName;
	@NotNull(message = "Cant be empty")
	private String email;
	@NotNull(message = "Cant be empty")
	@Size(min=8,max=26,message="Min length is 8 characters")
	private String password;

	public Registrationform() {

	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public String toString() {
		return "Registrationform [name=" + name + ", lastName=" + lastName + ", userName=" + userName + ", email="
				+ email + ", password=" + password + "]";
	}
	
	

}
