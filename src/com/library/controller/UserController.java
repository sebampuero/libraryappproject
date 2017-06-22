package com.library.controller;

import java.io.IOException;
import java.math.BigInteger;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.multipart.MultipartFile;

import com.library.entity.EditProfileForm;
import com.library.entity.Message;
import com.library.entity.Registrationform;
import com.library.entity.User;
import com.library.service.UserService;

@Controller
public class UserController {

	@Autowired
	UserService userService;
	
	@Autowired
	ApplicationEventPublisher eventPublisher;
	
	@Autowired
	JavaMailSender javaMailSender;

	/**
	 * Returns to the login page
	 * @param logout if the user logged out, show a conf message
	 * @param model the model
	 * @return
	 */
	@RequestMapping("/login")
	public String login(@RequestParam(value = "logout", required = false)String logout,
			@RequestParam(value="message",required=false)String passwordChangeMsg, Model model){
		if(logout != null)
			model.addAttribute("logout", "You have successfully logged out");
		if(passwordChangeMsg!=null)
			model.addAttribute("passwordMsg",passwordChangeMsg);
		return "login-form";
	}
	
	@GetMapping("/")
	public String startpage(){
		return "startpage";
	}
	
	/**
	 * When an unauthorized user tries to acces a mapping for role admin
	 * @return the access denied page
	 */
	@RequestMapping("/access_denied")
	public String access_denied(){
		return "access_denied";
	}
	/**
	 * Show the registration form
	 * @param regModel the Model
	 * @return the registration form view
	 */
	@RequestMapping("/showRegistrationForm")
	public String showRegistrationForm(Model regModel){
		Registrationform form = new Registrationform();
		regModel.addAttribute("form",form);
		return "registration-form";
	}
	/**
	 * Register a new user
	 * @param form the form object
	 * @param rs the bindingresult to check if there are errors
	 * @return
	 */
	@PostMapping("/registerUser")
	public String registerUser(@Valid@ModelAttribute("form")Registrationform form, BindingResult rs, WebRequest req){
		if(rs.hasErrors())
			return "registration-form";
		//true if the is an existing username, false if not
		boolean usernameExists = userService.registerNewUser(getFormToUser(form));
		if(usernameExists){
			//if username exists throw error 
			rs.rejectValue("userName","usernameAlreadyExists");
			return "registration-form";
		}
		return "redirect:/";
	}
	/**
	 * Show the forgotpassword form
	 * @return the forgot password form
	 */
	@GetMapping("/forgotPassword")
	public String forgotPassword(){
		return "forgot-password-form";
	}
	/**
	 * Get the form and handle the retrieval of a new password. An email is sent to the user.
	 * @param email the email of the user
	 * @param request the webrequest
	 * @return the login page for the confirmationof email sent
	 */
	@PostMapping("/forgotPassword")
	public String forgotPassword1(@RequestParam("email")String email, WebRequest request){
		User user = null;
		try{
			user = userService.findUserByEmail(email);
		}catch(Exception e){
			String emailDoesNotExist = "Email does not exist";
			return "redirect:/login?message="+emailDoesNotExist;
		}
		String token = UUID.randomUUID().toString();
		String emailSentMsg = "Email was sent";
		userService.createPasswordTokenForUser(user,token);
		javaMailSender.send(constructResetTokenEmail(request.getContextPath(), request.getLocale(), token, user));
		return "redirect:/login?message="+emailSentMsg;
	}
	
	/**
	 * Get the generated url and redirect to the password change form if valid
	 * @param model the model
	 * @param id the id of the user
	 * @param token the random generated token
	 * @return the password change form
	 */
	@GetMapping("/changePassword")
	public String showChangePasswordPage(Model model, 
			@RequestParam("id")int id,@RequestParam("token") String token){
		String result = userService.validatePasswordResetToken(id,token);
		if(result != null){
			return "redirect:/login?message="+result;
		}
		return "updatePassword";
	}
	/**
	 * Save the changed password of the user
	 * @param password the new password
	 * @return redirect to login 
	 */
	@PostMapping("/savePassword")
	public String savePassword(@RequestParam("password")String password){
		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		userService.changeUserPassword(user,password);
		String passwordChangedMsg = "Password was changed successfully";
		return "redirect:/login?message="+passwordChangedMsg;
	}
	/**
	 * Get request to the edit profile form of a logged user. 
	 * @param userName username of the current user
	 * @param model the model
	 * @return
	 */
	@GetMapping("/editProfile")
	public String editProfile(@RequestParam("userName")String userName,Model model){
		User user = userService.findByUsername(userName);
		EditProfileForm editform = new EditProfileForm();
		editform.setUserName(user.getUserName());
		editform.setName(user.getName());
		editform.setLastName(user.getLastName());
		editform.setEmail(user.getEmail());
		model.addAttribute("form",editform);
		return "editprofile_form";
	}
	/**
	 * Edit the profile of a user. Accept the form object and its binding result to check if there are errors
	 * @param theForm
	 * @param rs
	 * @return
	 * @throws IOException
	 */
	@PostMapping("/editProfile")
	public String editUserProfile(@Valid@ModelAttribute("form")EditProfileForm theForm, BindingResult rs) throws IOException{
		if(rs.hasErrors())
			return "editprofile_form";
		User user = userService.findByUsername(theForm.getUserName());
		user.setName(theForm.getName());
		user.setLastName(theForm.getLastName());
		user.setEmail(theForm.getEmail());
		user.setPassword(theForm.getPassword());
		userService.updateUser(user);
		return "redirect:/library/myAccount?profileEdited=true";
	}
	/**
	 * Retrieve profile pic of a user by its id. Get the bytes from the db using the Service and then send a reponse via HTTPResponse
	 * @param request the request
	 * @param response the response
	 */
	@GetMapping("/retrieveProfilePic")
	public void retrieveImage(HttpServletRequest request, HttpServletResponse response){
		String id = request.getParameter("userId");
		byte[] imageContent = (byte[]) userService.retrieveProfilePic(Integer.parseInt(id));
		response.setContentType("image/gif");
		response.setContentLengthLong(imageContent.length);
		try {
			response.getOutputStream().write(imageContent);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * Requires CommonsMultipartResolver in order to get multiple parameters like this
	 * upload a picture using Multipartfile. get those bytes and set that to the byte[] param in user. Update the user in the db using hibernate
	 * @param username username of user
	 * @param file the image
	 * @return my accouint view with confirmation message
	 * @throws IOException when the picture couldnt be uploaded
	 */
	@PostMapping("/uploadPicture")
	public String uploadPicture(@RequestParam("username")String username,@RequestParam("image")MultipartFile file){
		if(file==null || file.getSize() == 0)
			return "redirect:/library/myAccount?pictureUploaded=false";
		User user = userService.findByUsername(username);
		try {
			user.setImage(file.getBytes());
		} catch (IOException e) {
			return "redirect:/library/myAccount?pictureUploaded=false";
		}
		userService.updateUser(user);
		return "redirect:/library/myAccount?pictureUploaded=true";
	}
	/**
	 * Show the private messages of the current logged in user
	 * @param messageSentConf when a message was sent previously, this param contains the conf message
	 * @param model the model
	 * @return the pm view
	 */
	@RequestMapping("/showPMs")
	public String showPMs(@RequestParam(value="messageSent",required=false)String messageSentConf,Model model){
		if(messageSentConf!=null)
			model.addAttribute("messageSuccess","Message was sent successfully");
		model.addAttribute("messages",getCurrentLoggedUser().getMessages());
		return "private-messages";
	}
	/**
	 * Retrieve the form for the composal of a message. If its a reply, populate the fields with the necessary parameters
	 * @param model the model
	 * @param reply the reply message
	 * @param senderUsername the username of user which sent the message to reply
	 * @param subject the subject of the message to reply
	 * @return the composal form
	 */
	@GetMapping("/composeMessage")
	public String compose(Model model, @RequestParam(value="reply",required=false)String reply,
			@RequestParam(value="sender",required=false)String senderUsername,@RequestParam(value="subject",required=false)String subject){
		if(reply!=null && senderUsername != null && subject != null){
			model.addAttribute("replyMessage","Quote: " + reply);
			model.addAttribute("senderUsername",senderUsername);
			model.addAttribute("subject","RE: "+subject);
		}
		return "message-composal-form";
	}
	/**
	 * Send the message
	 * @param subject the subject
	 * @param content the content
	 * @param toUsername the recipient username
	 * @return showPMs view with confirmation message
	 */
	@PostMapping("/composeMessage")
	public String composeMessage(@RequestParam("subject")String subject, @RequestParam("content")String content,
				@RequestParam("to")String toUsername){
		Message message = new Message(getCurrentLoggedUser(),userService.findByUsername(toUsername),
					subject, content);
		userService.saveMessage(message);
		return "redirect:/showPMs?messageSent=true";
	}
	
    /**
     * Get the number of unread messages the current logged in user has
     * @param req the request
     * @param res the response
     * @throws IOException in case the is a error printing the number into the response
     */
	@GetMapping("/unread-msg-num")
	public void getNumOfUnreadMsg(HttpServletRequest req, HttpServletResponse res) throws IOException{
		Set<Message> messages = getCurrentLoggedUser().getMessages();
		int numberOfUnreadMsg = 0;
		for(Message m : messages){
			if(m.getIs_read()==0)
				numberOfUnreadMsg++;
		}
		res.getWriter().write(String.valueOf(numberOfUnreadMsg));
	}
	/**
	 * When the user clicks a message in the frontend, mark it as read
	 * @param messageId the message id
	 */
	@GetMapping("/readMessage")
	public void setReadMessage(@RequestParam("msgId")String messageId){
		userService.setAsReadMessage(Integer.parseInt(messageId));
	}
	/**
	 * This is the request method for the retrieval of users in the typeahead when sending a message
	 * @param query the query
	 * @return users list as json
	 */
	@GetMapping("/retrieveUsers")
	public @ResponseBody List<User> retrieveUsersJSON(@RequestParam("query")String query){
		List<User> users = userService.queryUsers(query);
		return users;
	}
	/**
	 * Delete a message
	 * @param messageId the id of the message to delete
	 * @return return a confirmation message
	 */
	@GetMapping("/deleteMsg")
	public @ResponseBody String deleteMsg(@RequestParam("msgId")String messageId){
		userService.deleteMessage(Integer.parseInt(messageId));
		String message = "Message was deleted";
		return message;
	}
	
	/**
	 * 
	 * @param contextPath
	 * @param locale
	 * @param token
	 * @param user
	 * @return
	 */
	private SimpleMailMessage constructResetTokenEmail(String contextPath, Locale locale, String token, User user) {
		String url = "http://localhost:8080" +contextPath + "/changePassword?id=" + 
			      user.getId() + "&token=" + token;
			    String message = "Click the link below in order to change your password modafucka,this link will expire in 15 minutes";
			    return constructEmail("Reset Password", message + " \r\n" + url, user);
	}
    /**
     * 
     * @param subject
     * @param body
     * @param user
     * @return
     */
	private SimpleMailMessage constructEmail(String subject, String body, User user) {
		SimpleMailMessage email = new SimpleMailMessage();
	    email.setSubject(subject);
	    email.setText(body);
	    email.setTo(user.getEmail());
	    return email;
	}
	/**
	 * Convert a form into a user
	 * @param form the form
	 * @return the user
	 */
	private static User getFormToUser(Registrationform form){
		User user = new User();
		user.setName(form.getName());
		user.setLastName(form.getLastName());
		user.setEmail(form.getEmail());
		user.setPassword(form.getPassword());
		user.setUserName(form.getUserName());
		return user;
	}
	/**
	 * Get the current logged in user from the SecurityContextHolder
	 * @return the User
	 */
	private User getCurrentLoggedUser(){
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User currentUser = userService.findByUsername(auth.getName());
		return currentUser;
	}
	
	//get every string input and trim it in case it has only blank spaces
	@InitBinder	public void initBinder(WebDataBinder dataBinder){
		StringTrimmerEditor editor = new StringTrimmerEditor(true);
		dataBinder.registerCustomEditor(String.class,editor);
	}
}

