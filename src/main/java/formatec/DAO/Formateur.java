package formatec.DAO;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import org.springframework.web.multipart.MultipartFile;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Entity
@Table(name = "formateur")
public class Formateur {
	@Transient
	public static final String typef = "formateur";

	@Id
	@GeneratedValue
	private long id_formateur;
	@Column(length = 100, nullable = false, unique = true)
	private String email;
	@Column(length = 100)
	private String fullname;
	@Column(length = 100)
	private String password;
	@Column(length = 100)
	private String city;
	@Column(length = 100)
	private String region;
	private String nomDeplom;
	private int niveau;
	private String deplom;
	private boolean etat;
	@OneToMany(mappedBy = "forma", cascade = CascadeType.ALL, targetEntity = Inscriptions.class)
	Set inscription = new HashSet();

	public long getId_formateur() {
		return id_formateur;
	}

	public void setId_formateur(long id_form) {
		this.id_formateur = id_form;
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

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public int getNiveau() {
		return niveau;
	}

	public void setNiveau(int niveau) {
		this.niveau = niveau;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getDeplom() {
		return deplom;
	}

	public void setDeplom(String deplom) {
		this.deplom = deplom;
	}

	public String getNomDeplom() {
		return nomDeplom;
	}

	public void setNomDeplom(String nomDeplom) {
		this.nomDeplom = nomDeplom;
	}

	@Transient
	public String getPhotosImagePath() {
		if ((this.deplom == null) || (this.email == null))
			return null;

		return "/allphoto/formateurs/" + this.email + "/" + this.deplom;
	}
	public boolean isEtat() {
		return etat;
	}

	public void setEtat(boolean etat) {
		this.etat = etat;
	}

}
