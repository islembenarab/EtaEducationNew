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
@Table(name = "Apprenant")
public class Apprenant {
	@Transient
	public static final String typea = "apprenant";
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	long id_apprenant;
	@Column(length = 100, nullable = false, unique = true)
	private String email;
	@Column(length = 100)
	private String fullname;
	@Column(length = 30)
	private String password;
	@Column(length = 50)
	private String city;
	private String region;
	private String nomDeplom;
	private String deplom;
	private boolean etat;

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getNomDeplom() {
		return nomDeplom;
	}

	public void setNomDeplom(String nomDeplom) {
		this.nomDeplom = nomDeplom;
	}

	public String getDeplom() {
		return deplom;
	}

	public void setDeplom(String deplom) {
		this.deplom = deplom;
	}

	private int niveau;

	@SuppressWarnings("rawtypes")
	@OneToMany(mappedBy = "app", cascade = CascadeType.ALL, targetEntity = Inscriptions.class)
	Set<Inscriptions> inscription = new HashSet();

	public long getId_apprenant() {
		return id_apprenant;
	}

	public void setId_apprenant(long id_app) {
		this.id_apprenant = id_app;
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

	@Transient
	public String getPhotosImagePath() {
		if ((this.deplom == null) || (this.email == null))
			return null;

		return "/allphoto/apprenants/" + this.email + "/" + this.deplom;
	}
	public boolean isEtat() {
		return etat;
	}

	public void setEtat(boolean etat) {
		this.etat = etat;
	}

}
