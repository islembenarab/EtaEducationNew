package formatec.DAO;


import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
@Entity
@Table(name="condidature")
public class Condidature {
	@Id
	@GeneratedValue
	private long id_condidature;
	@ManyToOne
    @JoinColumn(name ="id_for")
    private Formateur forma;
	@ManyToOne
    @JoinColumn(name ="id_eta")
    private Etablissement etab;
	@ManyToOne
    @JoinColumn(name ="id_formation")
    private Formation form;
	private boolean etat;
	private String demandeur;
	public long getId_condidature() {
		return id_condidature;
	}
	public void setId_condidature(long id_condidature) {
		this.id_condidature = id_condidature;
	}
	public Formation getForm() {
		return form;
	}
	public void setForm(Formation form) {
		this.form = form;
	}
	
	
	public Formateur getForma() {
		return forma;
	}
	public void setForma(Formateur forma) {
		this.forma = forma;
	}
	public Etablissement getEtab() {
		return etab;
	}
	public void setEtab(Etablissement etab) {
		this.etab = etab;
	}
	public boolean getEtat() {
		return etat;
	}
	public void setEtat(boolean etat) {
		this.etat = etat;
	}
	public String getDemandeur() {
		return demandeur;
	}
	public void setDemandeur(String demandeur) {
		this.demandeur = demandeur;
	}

}
