package formatec.service;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import javax.persistence.Id;


import formatec.DAO.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import formatec.repository.formationRepository;
import formatec.repository.inscriptionsRepository;

@Service
public class inscriptionsService {

	@Autowired
	private inscriptionsRepository inscR;

	public Inscriptions store(Inscriptions user) throws IOException {
		return inscR.save(user);
	}

	public Inscriptions getFile(long id) {
		return inscR.findById(id).get();
	}


	public List<Inscriptions> getAllFiles() {
		return inscR.findAll();
	}

	public List<Inscriptions> getAllFilesByIdApp(Apprenant app) {
		return inscR.findAllByapp(app);
	}
	public List<Inscriptions> getAllFilesByIdformateur(Formateur app) {
		return inscR.findAllByForma(app);
	}
	public List<Inscriptions> getAllFilesByIdformation(Formation app) {
		return inscR.findAllByForm(app);
	}
	public List<Inscriptions> getAllFilesByIdetablissement(Etablissement app) {
		return inscR.findAllByEtab(app);
	}
	
	public String deletFileById(long id) {
		if (inscR.existsById(id)) {
			inscR.deleteById(id);
			return "File has been successfully deleted";
		}
		return "File doesn't exist";
	}

	 

}