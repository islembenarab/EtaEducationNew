package formatec.service;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import formatec.DAO.Formation;
import formatec.repository.formationRepository;

import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;

@Service
public class formationService {

	@Autowired
	private formationRepository formationR;

	public Formation store(Formation user,MultipartFile file) throws IOException {
		String fileName = StringUtils.cleanPath(file.getOriginalFilename());
        user.setPhoto(fileName);
		return formationR.save(user);
	}public Formation update(Formation user) throws IOException {
		return formationR.save(user);
	}

	public Formation getFile(long id) {
		return formationR.findById(id).get();
	}
	public Formation getFilebyname(String id) {
		return formationR.findBynameFormation(id);
	}

	public List<Formation> getAllFiles() {
		return formationR.findAll();
	}
	public List<Formation> getAllFilesbyEtat(boolean etat) {
		return formationR.findAllByEtat(etat);
	}

	public String deletFileById(long id) {
		if (formationR.existsById(id)) {
			formationR.deleteById(id);
			return "File has been successfully deleted";
		}
		return "File doesn't exist";
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
	public static boolean sendmail(String email,String name) throws AddressException, MessagingException {
		try {


			Properties props = new Properties();
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", "587");
			Session session = Session.getInstance(props, new javax.mail.Authenticator() {
				@Override
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication("Benarab2001@gmail.com"
							, "BENARAB2000");
				}
			});
			Message msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress("benarab2001@gmail.com", false));

			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
			msg.setSubject("reponse de demande inscription");
			msg.setContent( "bonjour il y a une nouvelle formation son nom est" +
					name +
					" vérifiez-le, si vous l'aimez essayez-le", "text/html");
			msg.setSentDate(new Date());

			MimeBodyPart messageBodyPart = new MimeBodyPart();
			messageBodyPart.setContent("Tutorials point email", "text/html");

			Transport.send(msg);
			return true;
		} catch (AddressException e) {
			return false;
		} catch (MessagingException e) {
			return false;
		}

	}

}