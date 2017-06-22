package com.library.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.library.dao.LibraryDAO;
import com.library.entity.Book;
import com.library.entity.BookReview;
import com.library.entity.Loan;

@Service
public class LibraryServiceImpl implements LibraryService {
	
	@Autowired
	LibraryDAO libraryDAO;
	
	@Transactional
	@Override
	public void addBook(Book book) {
		libraryDAO.addBook(book);
		
	}
	
	@Transactional
	@Override
	public List<Book> showBooks() {
		return libraryDAO.showBooks();
	}

	@Transactional
	@Override
	public List<Book> searchBooks(String title) {
		return libraryDAO.searchBooks(title);
	}
	
	@Transactional
	@Override
	public byte[] retrieveImage(int id) {
		return libraryDAO.retrieveImage(id);
	}

	@Transactional
	@Override
	public List<Book> filterBooks(String filter) {
		return libraryDAO.filterBooks(filter);
	}

	@Transactional
	@Override
	public Book getBookById(int id) {
		return libraryDAO.getBookById(id);
	}


	@Transactional
	@Override
	public int loanBookToUser(Loan loan) {
		return libraryDAO.loanBookToUser(loan);
	}

	@Transactional
	@Override
	public void saveBookReview(BookReview theReview) {
		libraryDAO.saveBookReview(theReview);
	}

	

}
