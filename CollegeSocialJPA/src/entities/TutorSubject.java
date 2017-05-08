package entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name = "Tutor_Subject")
public class TutorSubject {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String subject;
	private float rating;
	private int rate;

	@JsonBackReference
	@ManyToOne
	@Column(name = "tutor_info")
	private TutorInfo tutorInfo;

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

	public float getRating() {
		return rating;
	}

	public void setRating(float rating) {
		this.rating = rating;
	}

	public int getRate() {
		return rate;
	}

	public void setRate(int rate) {
		this.rate = rate;
	}

	public TutorInfo getTutorInfo() {
		return tutorInfo;
	}

	public void setTutorInfo(TutorInfo tutorInfo) {
		this.tutorInfo = tutorInfo;
	}

	@Override
	public String toString() {
		return "TutorSubject [id=" + id + ", subject=" + subject + ", rating=" + rating + ", rate=" + rate + "]";
	}

}
