package com.library.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.StringTokenizer;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
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
import org.springframework.web.multipart.MultipartFile;

import com.library.entity.Author;
import com.library.entity.Book;
import com.library.entity.Loan;
import com.library.entity.Registrationform;
import com.library.entity.User;
import com.library.service.AdminService;
import com.library.service.LibraryService;
import com.library.service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	UserService userService;
	
	@Autowired
	LibraryService libraryService;
	
	@Autowired
	AdminService adminService;
	/**
	 * Return the create admin form from the get request
	 * @param model the model
	 * @return the create admin view
	 */
	@GetMapping("/createAdmin")
	public String createAdmin(Model model){
		Registrationform regForm = new Registrationform();
		model.addAttribute("regForm",regForm);
		return "create-admin";
	}
	/**
	 * Receive the form and create a new admin
	 * @param theForm  the form with the needed values
	 * @param rs the bindingresult for errors
	 * @return to the start page
	 */
	@PostMapping("/createAdmin")
	public String createTheAdmin(@Valid@ModelAttribute("regForm")Registrationform theForm, BindingResult rs){
		if(rs.hasErrors())
			return "create-admin";
		User user = getFormToUser(theForm);
		adminService.createNewAdminUser(user);
		return "redirect:/";
	}
	/**
	 * Show the admins control page
	 * @param model the model
	 * @return the admins control page view
	 */
	@RequestMapping("/adminsControlPage")
	public String showAdminsControlPage(Model model){
		List<User> admins = adminService.showAdmins();
		model.addAttribute("admins",admins);
		return "administrators-controlpanel";
	}
	
	@GetMapping("/searchAdmin")
	public String searchAdmin(@RequestParam("adminName")String adminName,Model model){
		List<User> admins = adminService.searchAdminByName(adminName);
		model.addAttribute("admins",admins);
		return "administrators-controlpanel";
	}
	/**
	 * Show all users registered
	 * @param model the model
	 * @return the users control panel view
	 */
	@RequestMapping("/showUsers")
	public String showUsers(Model model){
		List<User> users = adminService.showUsers();
		model.addAttribute("users",users);
		return "users-controlpanel";
	}
	/**
	 * Show the profile of a given user
	 * @param userName the username of the user
	 * @param model the model
	 * @return the view containing information about this user
	 */
	@GetMapping("/showUserProfile")
	public String showUserProfile(@RequestParam("userName")String userName,Model model){
		User user = userService.findByUsername(userName);
		Set<Loan> loans = user.getLoans();
		List<Book> booksLoanByUser = new ArrayList<>();
		for(Loan l : loans){
			Book book = l.getBook();
			book.setUserReturnDate(l.getDue_date());
			booksLoanByUser.add(book);
		}
		model.addAttribute("user",user);
		model.addAttribute("books",booksLoanByUser);
		return "userprofile-admin-view";
	}
	/**
	 * Return the form to create a new book
	 * @return the create book view form
	 */
	@GetMapping("/createBook")
	public String showCreateBookForm(){
		return "createbookform";
	}
	/**
	 * Receive the needed parameters and create a new book
	 * @param title the title of the new book
	 * @param description the description of the new book
	 * @param authors the authors of the new books (csv)
	 * @param numOfCopies the number of copies available for that new book
	 * @param file the file containing its image
	 * @return the view containing all available books
	 */
	@PostMapping("/createBook")
	public String createBook(@RequestParam("title")String title, @RequestParam("description")String description,
			@RequestParam("author")String authors,@RequestParam("copies")String numOfCopies, @RequestParam("image")MultipartFile file){
		Set<Author> authorSet = new HashSet<Author>();
		List<String> authorNames = trimCSVToStrings(authors);
		for(String name : authorNames){
			authorSet.add(new Author(name));
		}
		try {
			Book book = new Book(title,authorSet,file.getBytes(),Integer.parseInt(numOfCopies),description);
			libraryService.addBook(book);
			return "redirect:/library/showBooks";
		} catch (NumberFormatException | IOException e) {
			return "redirect:/library/showBooks";
		}
	}
	
	/*
	 * Helper methods
	 */
	//get every string input and trim it in case it has only blank spaces
	//very important!!
	@InitBinder	public void initBinder(WebDataBinder dataBinder){
		StringTrimmerEditor editor = new StringTrimmerEditor(true);
		dataBinder.registerCustomEditor(String.class,editor);
	}
	/**
	 * Get a form and convert it to a user
	 * @param form the form
	 * @return a new user with the given parameters of form
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
	 * Trim values in a CSV format and put them in a List
	 * @param csv the string with values in CSV format
	 * @return a list with values
	 */
	private static List<String> trimCSVToStrings(String csv){
		List<String> strings = new ArrayList<>();
		StringTokenizer token = new StringTokenizer(csv, ",");
		while(token.hasMoreTokens()){
			strings.add(token.nextToken().toString());
		}
		return strings;
	}
	
	
}
