package com.library.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.ColumnDefault;

@Entity
@Table
public class Message {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="message_id")
	private int id;
	
	@OneToOne
	@JoinColumn(name="from_id")
	private User sender;
	
	@OneToOne
	@JoinColumn(name="to_id")
	private User recipient;

	@Column
	private String subject;
	@Column
	private String content;
	@Column(insertable=false,updatable=false,nullable=false)
	@ColumnDefault("datetime default CURRENT_TIMESTAMP")
	private Date created_at;
	@Column(insertable=false,nullable=false)
	@ColumnDefault("TINYINT default 0")
	private int is_read;

	
	public Message() {

	}
		
	

	public Message(User sender, User recipient, String subject, String content) {
		this.sender = sender;
		this.recipient = recipient;
		this.subject = subject;
		this.content = content;
	}



	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}
	public int getIs_read() {
		return is_read;
	}
	public void setIs_read(int is_read) {
		this.is_read = is_read;
	}
	


	public User getSender() {
		return sender;
	}



	public void setSender(User sender) {
		this.sender = sender;
	}



	public User getRecipient() {
		return recipient;
	}



	public void setRecipient(User recipient) {
		this.recipient = recipient;
	}

}
