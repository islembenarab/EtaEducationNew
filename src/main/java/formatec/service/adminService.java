package formatec.service;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;

import formatec.DAO.Admin;
import formatec.repository.adminRepository;
@Service
public class adminService {

	@Autowired
	private adminRepository apprenatR;

	public Admin store(Admin user) throws IOException {
		return apprenatR.save(user);
	}
	

	public Admin getFile(String id) {
		return apprenatR.findByEmail(id);
	}
	
	
	public List<Admin> getAllFiles() {
		return apprenatR.findAll();
	}

	public String deletFileById(long id) {
		if (apprenatR.existsById(id)) {
			apprenatR.deleteById(id);
			return "File has been successfully deleted";
		}
		return "File doesn't exist";
	}
	public boolean authentify(String email,String password) {

		if (apprenatR.existsByEmail(email)){
			Admin app=apprenatR.findByEmail(email);
			return app.getPassword().equals(password);
		}
		return false;
	}
	public static boolean sendmail(String email,String name,boolean reponse) throws MessagingException {
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
		   if(reponse) {
		   msg.setContent("bonjour Ms."+name+"votre demande de l'inscription est bien accepter"
				   , "text/html");
		   }else {
			   msg.setContent( "bonjour Ms."+name+"votre demande est refuser svp Veuillez réessayer plus tard", "text/html");
		   }
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