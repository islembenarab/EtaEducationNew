package formatec.DAO;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Entity
@Table(name = "admin")
public class Admin {
	@Transient
	public static final String typead = "admin";
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	long id_ad;
	@Column(length = 100, nullable = false, unique = true)
	private String email;
	@Column(length = 100)
	private String fullname;
	@Column(length = 30)
	private String password;
	public long getId_app() {
		return id_ad;
	}

	public void setId_app(long id_app) {
		this.id_ad = id_app;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}


}
