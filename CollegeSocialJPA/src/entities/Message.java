package entities;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Message {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String message;
	@Column(name = "datetime")
	private Date messageDate;
	@ManyToOne
	@Column(name = "user_sent")
	private User userSent;
	@ManyToOne
	@Column(name = "user_received")
	private User userRecieved;

	public int getId() {
		return id;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Date getMessageDate() {
		return messageDate;
	}

	public void setMessageDate(Date messageDate) {
		this.messageDate = messageDate;
	}

	public User getUserSent() {
		return userSent;
	}

	public void setUserSent(User userSent) {
		this.userSent = userSent;
	}

	public User getUserRecieved() {
		return userRecieved;
	}

	public void setUserRecieved(User userRecieved) {
		this.userRecieved = userRecieved;
	}

	@Override
	public String toString() {
		return "Message [id=" + id + ", message=" + message + ", messageDate=" + messageDate + "]";
	}

}
