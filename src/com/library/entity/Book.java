package com.library.entity;

import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="books")
public class Book {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="Bid")
	private int id;
	@Column(name="Title")
	private String title;
	
	@JsonIgnore
	@ManyToMany(fetch = FetchType.LAZY,cascade = {CascadeType.ALL})
	@JoinTable(name="booksauthors", joinColumns={@JoinColumn(name="BookId")},
				inverseJoinColumns={@JoinColumn(name="AuthorId")})
	private Set<Author> authors = new HashSet<Author>();
	
	@OneToMany(mappedBy="book", fetch=FetchType.LAZY)
	private Set<Loan> loans = new HashSet<Loan>();
	
	@OneToMany(mappedBy="book",fetch=FetchType.LAZY)
	private Set<BookReview> reviews = new HashSet<BookReview>();
	
	public Book(String title, Set<Author> authors, byte[] image, int no_copies, String description) {
		this.title = title;
		this.authors = authors;
		this.image = image;
		this.no_copies = no_copies;
		this.description = description;
	}
	@Lob
	@Column(name="image",columnDefinition="mediumblob")
	private byte[] image;
	
	@Column(name="no_copies")
	private int no_copies;
	
	@Column(name="book_desc")
	private String description;
	
	@Transient
	private Date userReturnDate;

	public Book() {

	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Set<Author> getAuthors() {
		return authors;
	}
	public void setAuthors(Set<Author> authors) {
		this.authors = authors;
	}
	public int getNo_copies() {
		return no_copies;
	}
	public void setNo_copies(int no_copies) {
		this.no_copies = no_copies;
	}
	
	public byte[] getImage() {
		return image;
	}
	public void setImage(byte[] image) {
		this.image = image;
	}
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Set<Loan> getLoans() {
		return loans;
	}
	public void setLoans(Set<Loan> loans) {
		this.loans = loans;
	}
	public Date getUserReturnDate() {
		return userReturnDate;
	}
	public void setUserReturnDate(Date userReturnDate) {
		this.userReturnDate = userReturnDate;
	}
	public Set<BookReview> getReviews() {
		return reviews;
	}
	public void setReviews(Set<BookReview> reviews) {
		this.reviews = reviews;
	}
		
	
}
