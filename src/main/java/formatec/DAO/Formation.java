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
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Entity
@Table(name = "formation")
public class Formation {
	@Id
	@GeneratedValue
	private long id_formation;
	private String nameFormation;
	private double price;
	@Column(length = 60)
	private String filier;
	@Transient
	MultipartFile file;
	private String photo;
	private int niveau;
	private String duree;
	private boolean etat;
	@OneToMany(mappedBy = "form", cascade = CascadeType.ALL, targetEntity = Inscriptions.class)
	Set inscription = new HashSet();
	@OneToMany(mappedBy = "form", cascade = CascadeType.ALL, targetEntity = Condidature.class)
	Set condidature = new HashSet();
	@OneToMany(mappedBy = "formation", cascade = CascadeType.ALL, targetEntity = Offer.class)
	Set Offer = new HashSet();
	

	public String getName_formation() {
		return nameFormation;
	}


	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public void setName_formation(String name_formation) {
		this.nameFormation = name_formation;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getFilier() {
		return filier;
	}

	public void setFilier(String filier) {
		this.filier = filier;
	}

	public int getNiveau() {
		return niveau;
	}

	public void setNiveau(int niveau) {
		this.niveau = niveau;
	}

	public long getId_formation() {
		return id_formation;
	}

	public void setId_formation(long id_formation) {
		this.id_formation = id_formation;
	}

	@Transient
	public String getPhotosImagePath() {
		if ((this.photo == null) || (this.id_formation == 0))
			return null;

		return "/allphoto/formation/" + this.id_formation + "/" + this.photo;
	}

	public boolean isEtat() {
		return etat;
	}

	public void setEtat(boolean etat) {
		this.etat = etat;
	}

	public String getDuree() {
		return duree;
	}

	public void setDuree(String duree) {
		this.duree = duree;
	}

}
