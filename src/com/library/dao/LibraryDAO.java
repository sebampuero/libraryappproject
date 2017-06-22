package com.library.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.library.entity.Book;
import com.library.entity.BookReview;
import com.library.entity.Loan;

public interface LibraryDAO {

	public void addBook(Book book);
	
	public List<Book> showBooks();
	
	public List<Book> searchBooks(String title);

	public byte[] retrieveImage(int id);

	public List<Book> filterBooks(String filter);

	public Book getBookById(int id);

	public int loanBookToUser(Loan loan);


	public void saveBookReview(BookReview theReview);
	
}
