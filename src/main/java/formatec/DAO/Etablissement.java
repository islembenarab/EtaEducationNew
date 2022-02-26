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

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Entity
@Table(name = "etablissement")
public class Etablissement {
	@Transient
	public static String typet = "etablissement";
	@Id
	@GeneratedValue
	private long id_etab;
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
	@OneToMany(mappedBy = "etab", cascade = CascadeType.ALL, targetEntity = Inscriptions.class)
	Set inscription = new HashSet();
	@OneToMany(mappedBy = "etablissement", cascade = CascadeType.ALL, targetEntity = Offer.class)
	Set Offer = new HashSet();
	public long getId_etablissement() {
		return id_etab;
	}

	public void setId_etablissement(long id_etab) {
		this.id_etab = id_etab;
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

		return "/allphoto/etablissements/" + this.email + "/" + this.deplom;
	}

	public boolean isEtat() {
		return etat;
	}

	public void setEtat(boolean etat) {
		this.etat = etat;
	}
}
