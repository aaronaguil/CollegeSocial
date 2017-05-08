package entities;

import java.sql.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name = "Tutor_Info")
public class TutorInfo {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String description;

	@Column(name = "date_start")
	private Date startDate;
	
	@JsonBackReference
	@OneToOne
	@Column(name = "User_id")
	private User user;
	
	@JsonManagedReference
	@OneToMany(mappedBy = "tutorInfo")
	private List<TutorSubject> tutorSubject;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<TutorSubject> getTutorSubject() {
		return tutorSubject;
	}

	public void setTutorSubject(List<TutorSubject> tutorSubject) {
		this.tutorSubject = tutorSubject;
	}

	@Override
	public String toString() {
		return "TutorInfo [id=" + id + ", description=" + description + ", startDate=" + startDate + "]";
	}

}
