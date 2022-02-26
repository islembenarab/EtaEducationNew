package formatec.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import formatec.DAO.Admin;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import formatec.DAO.Apprenant;
import formatec.DAO.Etablissement;
import formatec.repository.*;
@Service
public class apprenantService {
	static public ArrayList<String> emailsapprenant= new ArrayList<String>() ;
	@Autowired
	private aprenantRepository apprenantR;
	@Autowired
	private inscriptionsRepository inscR;

	public Apprenant store(Apprenant user,MultipartFile file) throws IOException {
		String fileName = StringUtils.cleanPath(file.getOriginalFilename());
        user.setDeplom(fileName);
		return apprenantR.save(user);
	}
	public Apprenant update(Apprenant user) throws IOException {
		
		return apprenantR.save(user);
	}
	public Apprenant getFile(String id) {
		return apprenantR.findByEmail(id);
	}
	
	public Apprenant getFilebyId(long id) {
		return apprenantR.findById(id).get();
	}
	
	
	public List<Apprenant> getAllFiles() {
		return apprenantR.findAll();
	}
	public List<Apprenant> getAllFilesByetat(boolean etat) {
		return apprenantR.findAllByEtat(etat);
	}

	public String deletFileById(long id) {
		if (apprenantR.existsById(id)) {
			apprenantR.deleteById(id);
			return "File has been successfully deleted";
		}
		return "File doesn't exist";
	}
	public boolean authentify(String email,String password) {
		if (apprenantR.existsByEmail(email)){
			Apprenant app=apprenantR.findByEmail(email);
			return app.getPassword().equals(password);
		}
		return false;
	}
	
	
	
}