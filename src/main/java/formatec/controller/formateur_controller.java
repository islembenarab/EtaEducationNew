package formatec.controller;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import formatec.DAO.Condidature;
import formatec.DAO.Formateur;
import formatec.DAO.Formation;
import formatec.DAO.payment;
import formatec.service.*;
@Controller
public class formateur_controller {
	@Autowired
	formateurService formateurS;
	@Autowired
	formationService formationS;
	@Autowired
	condidatureService condS;
	@Autowired
	paymentService payS;
	@Autowired
	etablissementService etabS;

	@GetMapping(value = "/profile_formateur")
	public String profile_app(Model model, HttpSession session) {
		if(session.getAttribute("logged")==null)
			return"redirect:/sign_in";
		model.addAttribute("name", session.getAttribute("name"));
		Formateur app = formateurS.getFile((String) session.getAttribute("email"));
		model.addAttribute("email", app.getEmail());
		model.addAttribute("name", app.getFullname());
		model.addAttribute("mdp",app.getPassword());
		model.addAttribute("ville", app.getCity());
		model.addAttribute("condidaturesattent",condS.getAllFilesByetatAndforma(false,app,"etablissement"));
		model.addAttribute("condidaturesaccepter",condS.getAllFilesByetatAndforma(true,app));
		if(session.getAttribute("message1")==null)
			session.setAttribute("message1", "");
		model.addAttribute("message1",session.getAttribute("message1"));
		return "profile_formateur";
	}

	@PostMapping(value = "/verifierpassform")
	@ResponseBody
	public boolean verifier(String pass, HttpSession session, Model model) {

		if (formateurS.getFile((String) session.getAttribute("email")).getPassword().equals(pass)) {
			
			return true;
		}
		return false;
	}
	@PostMapping(value = "/changeinfoform")
	public String change(@ModelAttribute("formateur")Formateur app, HttpSession session) {
		System.out.println(app.getEmail()+app.getFullname()+app.getCity()+app.getPassword());
		Formateur appre = formateurS.getFile((String) session.getAttribute("email"));
		appre.setEmail(app.getEmail());
		appre.setFullname(app.getFullname());
		appre.setCity(app.getCity());
		appre.setPassword(app.getPassword());
		try {
			formateurS.update(appre);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return"redirect:/logout";
	}
	@PostMapping(value = "/proposeF")
	public String prpose(@ModelAttribute("formation")Formation Formation,@RequestParam("file")MultipartFile file,HttpSession session) {
		
		Formation.setEtat(false);
		try {
			formationS.store(Formation,file);
			String uploaddir = "allphoto/formation/" +formationS.getFilebyname(Formation.getName_formation()).getId_formation();
			formationService.saveFile(uploaddir, formationS.getFilebyname(Formation.getName_formation()).getPhoto(), file);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		session.setAttribute("message1", "votre formation est bien recu svp attender l'acceptation");
		return "redirect:/profile_formateur";
	}
	@GetMapping(value = "/reponsecondidature/{reponse}/{id_condidature}")
	public String addformation(@PathVariable("reponse") boolean reponse,@PathVariable("id_condidature") String id,HttpSession session) {
		long idF=Long.parseLong(id);
		
		if(reponse) {
		Condidature Formation=condS.getFile(idF);
		Formation.setEtat(reponse);
		try {
			condS.store(Formation);
			for (String email:apprenantService.emailsapprenant) {
				formationService.sendmail(email,Formation.getForm().getName_formation());
			}
			session.setAttribute("message2", "le condidature est bien accepte");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (AddressException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		}else {
			System.out.println(condS.deletFileById(idF));
			session.setAttribute("message2", "le formation est bien refuse");
		}
		return "redirect:/profile_formateur";
	}
	@GetMapping(value = "/demandecond/{id_etab}/{id_formation}")
	public String demandecond(@PathVariable("id_etab") String idEtab,@PathVariable("id_formation") String idFormation,HttpSession session) {
		if(session.getAttribute("logged")==null) {
			return "redirect:/sign_in";
		}else {
		long IdFormation=Long.parseLong(idFormation);
		long IdEtab=Long.parseLong(idEtab);
		Condidature cond=new Condidature();
		cond.setEtab(etabS.getFilebyId(IdEtab));
		cond.setForm(formationS.getFile(IdFormation));
		cond.setForma(formateurS.getFile((String) session.getAttribute("email")));
		cond.setEtat(false);
		cond.setDemandeur(Formateur.typef);
		try {
			condS.store(cond);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/profile_formateur";	
	}
		}

}
