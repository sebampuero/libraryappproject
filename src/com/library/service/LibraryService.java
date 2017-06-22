package com.library.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.security.access.annotation.Secured;

import com.library.entity.Book;
import com.library.entity.BookReview;
import com.library.entity.Loan;

public interface LibraryService {
	
	@Secured({"ROLE_ADMIN"})
	void addBook(Book book);
	
	List<Book> showBooks();
	
	List<Book> searchBooks(String title);

	byte[] retrieveImage(int id);

	List<Book> filterBooks(String filter);

	Book getBookById(int parseInt);

	int loanBookToUser(Loan loan);

	void saveBookReview(BookReview theReview);

	

}
