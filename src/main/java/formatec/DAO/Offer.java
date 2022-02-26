package formatec.DAO;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="offer")
public class Offer {
	@Id
	@GeneratedValue
	private long id_offer;
	private String nomeOffer;
	@ManyToOne
	@JoinColumn(name = "id_etab")
	private Etablissement etablissement;
	@ManyToOne
	@JoinColumn(name = "id_formation")
	private Formation formation;
	public long getId_offer() {
		return id_offer;
	}
	public void setId_offer(long id_offer) {
		this.id_offer = id_offer;
	}
	public String getNomeOffer() {
		return nomeOffer;
	}
	public void setNomeOffer(String nomeOffer) {
		this.nomeOffer = nomeOffer;
	}
	public Etablissement getEtablissement() {
		return etablissement;
	}
	public void setEtablissement(Etablissement etablissement) {
		this.etablissement = etablissement;
	}
	public Formation getFormation() {
		return formation;
	}
	public void setFormation(Formation formation) {
		this.formation = formation;
	}
	
}
