package entities;

import java.sql.Date;
import java.util.List;

import javax.management.Notification;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String username;
	private String password;
	private String firstName;
	private String lastName;
	private String major;
	private String classification;
	@Column(name = "registration_date")
	private Date date;
	private boolean admin;
	@JsonManagedReference
	@OneToMany(mappedBy = "user")
	private List<Notification> notifications;
	@JsonManagedReference
	@OneToOne(mappedBy = "user")
	private TutorInfo tutorInfo;
	@JsonBackReference
	@OneToMany(mappedBy = "user")
	private List<Message> messagesSent;
	@JsonBackReference
	@OneToMany(mappedBy = "user")
	private List<Message> messagesReceived;
	@JsonManagedReference
	@ManyToMany
	@JoinTable(name = "User_Institution", joinColumns = @JoinColumn(name = "User_id", referencedColumnName = "id"), inverseJoinColumns = @JoinColumn(name = "Institution_id"))
	private List<Institution> institutions;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getMajor() {
		return major;
	}

	public void setMajor(String major) {
		this.major = major;
	}

	public String getClassification() {
		return classification;
	}

	public void setClassification(String classification) {
		this.classification = classification;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public boolean isAdmin() {
		return admin;
	}

	public void setAdmin(boolean admin) {
		this.admin = admin;
	}

	public List<Notification> getNotifications() {
		return notifications;
	}

	public void setNotifications(List<Notification> notifications) {
		this.notifications = notifications;
	}

	public TutorInfo getTutorInfo() {
		return tutorInfo;
	}

	public void setTutorInfo(TutorInfo tutorInfo) {
		this.tutorInfo = tutorInfo;
	}

	public List<Message> getMessagesSent() {
		return messagesSent;
	}

	public void setMessagesSent(List<Message> messagesSent) {
		this.messagesSent = messagesSent;
	}

	public List<Message> getMessagesReceived() {
		return messagesReceived;
	}

	public void setMessagesReceived(List<Message> messagesReceived) {
		this.messagesReceived = messagesReceived;
	}

	public List<Institution> getInstitutions() {
		return institutions;
	}

	public void setInstitutions(List<Institution> institutions) {
		this.institutions = institutions;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", firstName=" + firstName
				+ ", lastName=" + lastName + ", major=" + major + ", classification=" + classification + ", date="
				+ date + ", admin=" + admin + "]";
	}

}
