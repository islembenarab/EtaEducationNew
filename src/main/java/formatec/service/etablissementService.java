package formatec.service;

import java.io.IOException;
import java.util.List;

import formatec.DAO.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import formatec.DAO.Etablissement;
import formatec.DAO.Formateur;
import formatec.repository.etablissementRepository;
@Service
public class etablissementService {

	@Autowired
	private etablissementRepository etablissementR;

	public Etablissement store(Etablissement user,MultipartFile file) throws IOException {
		String fileName = StringUtils.cleanPath(file.getOriginalFilename());
        user.setDeplom(fileName);
		return etablissementR.save(user);
	}
	public Etablissement update(Etablissement user) throws IOException {
		
		return etablissementR.save(user);
	}

	public Etablissement getFile(String id) {
		return etablissementR.findByEmail(id);
	}
	public Etablissement getFilebyId(long id) {
		return etablissementR.getById(id);
	}
	public List<Etablissement> getAllFiles() {
		return etablissementR.findAll();
	}
	public List<Etablissement> getAllFilesByEtat(boolean etat) {
		return etablissementR.findAllByEtat(etat);
	}

	public String deletFileById(long id) {
		if (etablissementR.existsById(id)) {
			etablissementR.deleteById(id);
			return "File has been successfully deleted";
		}
		return "File doesn't exist";
	}
	public boolean authentify(String email,String password) {
		if (etablissementR.existsByEmail(email)){
			Etablissement app=etablissementR.findByEmail(email);
			return app.getPassword().equals(password);
		}
		return false;
	}
	
}