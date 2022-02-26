package formatec.service;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.stream.Stream;

import formatec.DAO.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import formatec.DAO.Apprenant;
import formatec.DAO.Formateur;
import formatec.repository.formateurRepository;

@Service
public class formateurService {

	@Autowired
	private formateurRepository formateurR;

	public Formateur store(Formateur user,MultipartFile file) throws IOException {
		String fileName = StringUtils.cleanPath(file.getOriginalFilename());
        user.setDeplom(fileName);
		return formateurR.save(user);
	}
	public Formateur update(Formateur user) throws IOException {
		
		return formateurR.save(user);
	}

	public Formateur getFile(String id) {
		return formateurR.findByEmail(id);
	}
	public Formateur getFilebyId(long id) {
		return formateurR.getById(id);
	}

	public List<Formateur> getAllFiles() {
		return formateurR.findAll();
	}
	public List<Formateur> getAllFilesByEtat(boolean etat) {
		return formateurR.findAllByEtat(etat);
	}

	public String deletFileById(long id) {
		if (formateurR.existsById(id)) {
			formateurR.deleteById(id);
			return "File has been successfully deleted";
		}
		return "File doesn't exist";
	}
	public boolean authentify(String email,String password) {
		if (formateurR.existsByEmail(email)){
			Formateur app=formateurR.findByEmail(email);
			return app.getPassword().equals(password);
		}
		return false;
	}
	  public static void saveFile(String uploadDir, String fileName,
	            MultipartFile multipartFile) throws IOException {
	        Path uploadPath = Paths.get(uploadDir);
	         
	        if (!Files.exists(uploadPath)) {
	            Files.createDirectories(uploadPath);
	        }
	         
	        try (InputStream inputStream = multipartFile.getInputStream()) {
	            Path filePath = uploadPath.resolve(fileName);
	            Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
	        } catch (IOException ioe) {        
	            throw new IOException("Could not save image file: " + fileName, ioe);
	        }      
	    }

}