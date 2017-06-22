package com.library.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.library.entity.Book;
import com.library.entity.BookReview;
import com.library.entity.Loan;

@Repository
public class LibraryDAOImpl implements LibraryDAO {

	@Autowired
	SessionFactory sessionFactory;
	
	@Override
	public void addBook(Book book) {
		Session session = sessionFactory.getCurrentSession();
		session.save(book);
	}
	/**
	 * Return the list of all books in db
	 */
	public List<Book> showBooks(){
		Session session = sessionFactory.getCurrentSession();
		@SuppressWarnings("unchecked")
		List<Book> books = session.createQuery("from Book").getResultList();
		return books;
	}
	/**
	 * Return a list of searched books according to the title
	 */
	@Override
	public List<Book> searchBooks(String title) {
		Session session  = sessionFactory.getCurrentSession();
		@SuppressWarnings("unchecked")
		List<Book> books = session.createQuery("from Book where Title like :title").
				setParameter("title", "%" + title + "%").getResultList();
		if(books.isEmpty())
			return null;
		return books;
	}
 /**
  * Retrieve the image of a book using its id
  */
	@Override
	public byte[] retrieveImage(int id) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("select image from Book where id=:id").setParameter("id", id);
		byte[] content = (byte[]) query.getSingleResult();
		return content;
	}

	/*
	 * (non-Javadoc) Return a list of books given a filter. (method temporarily not working)
	 * @see com.library.dao.LibraryDAO#filterBooks(java.lang.String)
	 */
	@Override
	public List<Book> filterBooks(String filter) {
		Session session  = sessionFactory.getCurrentSession();
		@SuppressWarnings("unchecked")
		List<Book> books = session.createQuery("from Book order by :filter").
				setParameter("filter", filter).getResultList();
		if(books.isEmpty())
			return null;
		return books;
	}
    /*
     * (non-Javadoc) self explanatory
     * @see com.library.dao.LibraryDAO#getBookById(int)
     */
	@Override
	public Book getBookById(int id) {
		Session session = sessionFactory.getCurrentSession();
		Book book = session.get(Book.class, id);
		return book;
	}
	
	/*
	 * (non-Javadoc) Loan a book to a user.
	 * @see com.library.dao.LibraryDAO#loanBookToUser(int, int, java.util.Date, java.util.Date)
	 */
	@Override
	public int loanBookToUser(Loan loan) {
		Session session = sessionFactory.getCurrentSession();
		try{
			session.save(loan);
			return 1;
			//this returns the number of affected rows by the query, in this case 1
		}catch(Exception e){
			return 0; //return 0 if there was an error loaning book, for instance: when the user tries to loan a book he already loaned
		}
	}
	/*
	 * (non-Javadoc) Save a review of a book into the db
	 * @see com.library.dao.LibraryDAO#saveBookReview(com.library.entity.BookReview)
	 */
	@Override
	public void saveBookReview(BookReview theReview) {
		Session session = sessionFactory.getCurrentSession();
		session.save(theReview);
	}

}















