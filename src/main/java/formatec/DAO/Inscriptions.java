package formatec.DAO;


import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Entity
@Table(name = "inscriptions")
public class Inscriptions {
	@Id
	@GeneratedValue
	private long id_insc;
	@ManyToOne
    @JoinColumn(name ="id_app")
    private Apprenant app;
	@ManyToOne
    @JoinColumn(name ="id_for")
    private Formateur forma;
	@ManyToOne
    @JoinColumn(name ="id_eta")
    private Etablissement etab;
	@ManyToOne
    @JoinColumn(name ="id_formation")
    private Formation form;
	@SuppressWarnings("rawtypes")
	@OneToMany(mappedBy = "Intent", cascade = CascadeType.ALL, targetEntity = payment.class)
	Set payment = new HashSet();
	
	
	public Apprenant getApp() {
		return app;
	}
	public void setApp(Apprenant app) {
		this.app = app;
	}
	public Formateur getForma() {
		return forma;
	}
	public Formation getFormation() {
		return form;
	}
	public long getId_insc() {
		return id_insc;
	}
	public void setId_insc(long id_insc) {
		this.id_insc = id_insc;
	}
	public void setFormation(Formation Formation) {
		this.form = Formation;
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


}
