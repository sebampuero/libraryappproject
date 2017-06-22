package com.library.entity;

import java.util.Arrays;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class EditProfileForm {
	
	private String userName;
	
	@NotNull(message="Cannot be empty")
	private String name;
	@NotNull(message="Cannot be empty")
	private String lastName;
	@NotNull(message="Cannot be empty")
	private String email;
	@NotNull(message="Cannot be empty")
	@Size(min=8,message="Min 8 characters")
	private String password;
	
	private byte[] image;

	public EditProfileForm() {

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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public byte[] getImage() {
		return image;
	}

	public void setImage(byte[] image) {
		this.image = image;
	}

	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	@Override
	public String toString() {
		return "EditProfileForm [userName=" + userName + ", name=" + name + ", lastName=" + lastName + ", email="
				+ email + ", image=" + Arrays.toString(image) + "]";
	}
	


	
	
	

}
