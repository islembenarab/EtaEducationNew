package formatec.service;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import javax.persistence.Id;


import formatec.DAO.Formation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import formatec.DAO.Condidature;
import formatec.DAO.Etablissement;
import formatec.DAO.Formateur;
import formatec.repository.condidatureRepository;

@Service
public class condidatureService {

	@Autowired
	private condidatureRepository formationR;

	public Condidature store(Condidature user) throws IOException {
		return formationR.save(user);
	}

	public Condidature getFile(long id) {
		return formationR.findById(id).get();
	}

	public List<Condidature> getAllFiles() {
		return formationR.findAll();
	}
	public List<Condidature> getAllFilesByIdFormateur(Formateur forma) {
		return formationR.findAllByForma(forma);
	}
	public List<Condidature> getAllFilesByIdFormation(Formation forma) {
		return formationR.findAllByForm(forma);
	}
	public List<Condidature> getAllFilesByIdEtab(Etablissement forma) {
		return formationR.findAllByEtab(forma);
	}
	public List<Condidature> getAllFilesByetat(boolean forma) {
		return formationR.findAllByetat(forma);
	}
	public List<Condidature> getAllFilesByetatAndetab(boolean forma,Etablissement etab,String type) {
		return formationR.findAllByetatAndEtabAndDemandeur(forma,etab,type);
	}
	public List<Condidature> getAllFilesByetatAndforma(boolean forma,Formateur etab,String type) {
		return formationR.findAllByetatAndFormaAndDemandeur(forma,etab,type);
	}
	public List<Condidature> getAllFilesByetatAndetab(boolean forma,Etablissement etab) {
		return formationR.findAllByetatAndEtab(forma,etab);
	}
	public List<Condidature> getAllFilesByetatAndforma(boolean forma,Formateur etab) {
		return formationR.findAllByetatAndForma(forma,etab);
	}

	public String deletFileById(long id) {
		if (formationR.existsById(id)) {
			formationR.deleteById(id);
			return "File has been successfully deleted";
		}
		return "File doesn't exist";
	}

	 

}