package com.library.controller;



import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.library.entity.Book;
import com.library.entity.BookReview;
import com.library.entity.Loan;
import com.library.entity.User;
import com.library.service.LibraryService;
import com.library.service.UserService;

/**
 * Controller class for the Library
 * @author Sebastian
 *
 */
@Controller
@RequestMapping("/library")
public class LibraryController {
	
	@Autowired
	LibraryService libraryService;
	
	@Autowired
	UserService userService;
	
	/**
	 * Show all available books
	 * @param model the model
	 * @return the books view
	 */
	@RequestMapping("/showBooks")
	public String showBooks(Model model){
		model.addAttribute("books",libraryService.showBooks());
		return "booksview";
	}
	/**
	 * Show the details of a book using its id. get the book by id using the service
	 * @param bookId the book id
	 * @param model the model
	 * @return the book details view
	 */
	@GetMapping("/showBookDetails")
	public String showBookDetails(@RequestParam("book-id")String bookId,Model model){
		Book book = libraryService.getBookById(Integer.parseInt(bookId));
		float rankingAvg = 0;
		Set<BookReview> reviews = book.getReviews();
		for(BookReview br : reviews){
			rankingAvg = rankingAvg + br.getRanking();
		}
		rankingAvg = rankingAvg / book.getReviews().size();
		model.addAttribute("rankingAvg",rankingAvg);
		model.addAttribute("book",book);
		return "book_details";
	}
	/**
	 * Retrieve the image of  abook by its id. Get the bytes from the db and retrieve it to the jsp using HTTPResponse
	 * @param request the request
	 * @param response the response
	 */
	@GetMapping("/retrieveImage")
	public void retrieveImage(HttpServletRequest request, HttpServletResponse response){
		String id = request.getParameter("id");
		byte[] content = (byte[]) libraryService.retrieveImage(Integer.parseInt(id));
		response.setContentType("image/gif");
		response.setContentLength(content.length);
		try {
			response.getOutputStream().write(content);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * Retrieve all books that go according to the sort filter. As this is an arraylist that needs to be passed
	 * a responsebody needs to be used in order to not return a view, but a json object
	 * @param filter the filter
	 * @param model the model
	 * @return the books view 
	 */
	@GetMapping("/retriveBooksFilter")
	public  String filterBooks(@RequestParam("param")String filter, Model model){
		List<Book> books = libraryService.filterBooks(filter);
		model.addAttribute("books",books);
		return "booksview";
	}
	/**
	 * Retrieves all books that match with the searching parameter
	 * @param searchParam the searching parameter
	 * @param model the model
	 * @return the books view
	 */
	@GetMapping("/searchBooksByName")
	public String searchBooksByName(@RequestParam("param")String searchParam,Model model){
		List<Book> books = libraryService.searchBooks(searchParam);
		model.addAttribute("books",books);
		return "booksview";
	}
	/**
	 * Loan a book to the current logged in user. Parameters like bookid and the dates are needed
	 * @param bookId the book id to loan 
	 * @param loanDate the loan date
	 * @param returnDate the deturn date
	 * @return the books view
	 * @throws ParseException when a date cannot be parsed
	 */
	@PostMapping("/loanBook")
	public String loanBook(@RequestParam("bookId")String bookId,@RequestParam("loan_date")String loanDate
			,@RequestParam("return_date")String returnDate) throws ParseException{
		//format dates according to the parameters the strings are coming with
		//as the loandate is passed by the input date of html5, the string pattern is different
		//take in mind this has to be changed anytime, because firefox does not have support for input type date
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		DateFormat format2 = new SimpleDateFormat("dd.MM.yyyy");
		format2.setLenient(false);
		format.setLenient(false);
		Date theLoanDate = format.parse(loanDate);
		Date theReturnDate = format2.parse(returnDate);
		
		Loan loan = new Loan(libraryService.getBookById(Integer.parseInt(bookId)),getCurrentLoggedUser(),
				theLoanDate,theReturnDate);
		try{
			int status = libraryService.loanBookToUser(loan);
		}catch(Exception e){
			return "redirect:/library/myBooks?bookNotLoaned=true";
		}	
		return "redirect:/library/myBooks?bookLoaned=true";
	}
	/**
	 * Get to the my account page. This also evaluates if a profile was edited before, or a profile picture was edited
	 * in order to show confirmation messages in the frontend
	 * Search the current authenticated user in the spring context in order to be used in the view model (myaccount.jsp)
	 * @param edited if profile was edited
	 * @param pictureUploaded if pictured was uploaded
	 * @param model the model
	 * @return the account view
	 */
	@RequestMapping("/myAccount")
	public String showAccount(@RequestParam(value ="profileEdited",required=false)String edited,
			@RequestParam(value="pictureUploaded",required=false)String pictureUploaded,Model model){
		if(edited!=null)
			model.addAttribute("profileEditedSuccess", "Profile was edited successfully");
		if(pictureUploaded!=null){
			if(pictureUploaded.equals("true"))
				model.addAttribute("pictureUploaded","Picture uploaded successfully!");
			else
				model.addAttribute("pictureUploaded","Picture could not be loaded!");
		}
		model.addAttribute("currentUser",getCurrentLoggedUser());
		return "my_account";
	}
	/**
	 * Show the page user`s loaned books. This method receives status parameters for when a book was
	 * loaned successfully or with errors
	 * @param model the model
	 * @param bookLoaned if book was succesfully loaned
	 * @param bookNotLoaned if book was not successfully loaned
	 * @return the my books view
	 */
	@RequestMapping("/myBooks")
	public String myBooks(Model model,@RequestParam(value="bookLoaned",required=false)String bookLoaned,
				@RequestParam(value="bookNotLoaned",required=false)String bookNotLoaned){
		if(bookLoaned!=null)
			model.addAttribute("bookLoaned","Book was loaned!");
		if(bookNotLoaned!=null)
			model.addAttribute("bookNotLoaned","You can't loan the same book again!");
		User user = getCurrentLoggedUser(); //get the current user
		Set<Loan> loans = user.getLoans(); //get the loands in the user
		List<Book> myBooks = new ArrayList<>();
		for(Loan l : loans){
			Book book = l.getBook();
			book.setUserReturnDate(l.getDue_date());
			myBooks.add(book); //add every book in loans in the List
		}
		model.addAttribute("myBooks",myBooks);
		return "mybooks";
	}
	/**
	 * Save a review for a given book
	 * @param bookId the book id
	 * @param rank the rank
	 * @param review the review
	 * @return the books view
	 */
	@PostMapping("/saveBookReview")
	public String saveBookReview(@RequestParam("book-id")String bookId,
			@RequestParam("radioOption")String rank,@RequestParam("review")String review){
		Book book = libraryService.getBookById(Integer.parseInt(bookId));
		BookReview theReview = new BookReview(review,book,Integer.parseInt(rank));
		libraryService.saveBookReview(theReview);
		return "redirect:/library/showBooks";
	}
	
	/**
	 * Get the current logged in user from the Spring Security Context
	 * @return the current logged in user
	 */
	private User getCurrentLoggedUser(){
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		User currentUser = userService.findByUsername(auth.getName());
		return currentUser;
	}

}













