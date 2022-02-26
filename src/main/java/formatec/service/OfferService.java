package formatec.service;

import java.util.List;

import formatec.DAO.Etablissement;
import formatec.DAO.Formation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import formatec.DAO.Offer;
import formatec.repository.OfferRepository;

@Service
public class OfferService {
	@Autowired
	OfferRepository offerR;
	public Offer getFile(long id) {
		return offerR.getById(id);
	}
	public Offer store (Offer off) {
		return offerR.save(off);
	}
	public List<Offer> getAllfile(){
		return offerR.findAll();
	}
	public List<Offer> getAllfilebyformation(Formation formation){
		return offerR.findAllByFormation(formation);
	}
	public List<Offer> getAllfilebyetab(Etablissement etab){
		return offerR.findAllByEtablissement(etab);
	}
	public String deletbyid(long id) {
		if(offerR.existsById(id)) {
			offerR.deleteById(id);
			return "offer deleted";
		}
		return"offer not exist";
	}

}
