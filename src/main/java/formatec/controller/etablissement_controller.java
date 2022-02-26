package formatec.controller;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.http.HttpSession;

import formatec.DAO.*;
import formatec.repository.inscriptionsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import formatec.repository.SseService;
import formatec.service.*;
@Controller
public class etablissement_controller {
	@Autowired
	etablissementService etablissementS;
	@Autowired
	formationService formationS;
	@Autowired
	formateurService formateurS;
	@Autowired
	condidatureService condS;
	@Autowired
	OfferService offerS;
	@Autowired
	SseService sseService;
	@Autowired
	inscriptionsService inscS;
	@Autowired
	inscriptionsRepository inscR;
	@GetMapping(value = "/profile_etablissement")
	public String profile_app(Model model, HttpSession session) {
		if(session.getAttribute("logged")==null)
			return"redirect:/sign_in";
		model.addAttribute("name", session.getAttribute("name"));
		Etablissement app = etablissementS.getFile((String) session.getAttribute("email"));
		model.addAttribute("email", app.getEmail());
		model.addAttribute("name", app.getFullname());
		model.addAttribute("mdp",app.getPassword());
		model.addAttribute("ville", app.getCity());
		model.addAttribute("formationsattent",formationS.getAllFilesbyEtat(false));
		model.addAttribute("formationsaccepter",formationS.getAllFilesbyEtat(true));
		model.addAttribute("formateurs",formateurS.getAllFiles());
		model.addAttribute("condidaturesattent",condS.getAllFilesByetatAndetab(false,app,"formateur"));
		model.addAttribute("offers",offerS.getAllfile());
		model.addAttribute("condidaturesaccepter",condS.getAllFilesByetatAndetab(true,app));
		model.addAttribute("formations",inscR.findAllByEtab(app));
		if (session.getAttribute("message2")==null)
				session.setAttribute("message2", "  ");
		model.addAttribute("message2",session.getAttribute("message2"));
		return "profile_etablissement";
	}

	@PostMapping(value = "/verifierpassetab")
	@ResponseBody
	public boolean verifier(String pass, HttpSession session, Model model) {

		if (etablissementS.getFile((String) session.getAttribute("email")).getPassword().equals(pass)) {
			
			return true;
		}
		return false;
	}
	@PostMapping(value = "/changeinfoetab")
	public String change(@ModelAttribute("etablissementS")Etablissement etab, HttpSession session) {
		System.out.println(etab.getEmail()+etab.getFullname()+etab.getCity()+etab.getPassword());
		Etablissement appre = etablissementS.getFile((String) session.getAttribute("email"));
		appre.setEmail(etab.getEmail());
		appre.setFullname(etab.getFullname());
		appre.setCity(etab.getCity());
		appre.setPassword(etab.getPassword());
		try {
			etablissementS.update(appre);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		session.setAttribute("message", "SVP se connect pour applique les changement");
		return"redirect:/logout";
	}
	@GetMapping(value = "/addformation/{reponse}/{id_formation}")
	public String addformation(@PathVariable("reponse") boolean reponse,@PathVariable("id_formation") String id,HttpSession session) {
		long idF=Long.parseLong(id);
		
		if(reponse) {
		Formation Formation=formationS.getFile(idF);
		Formation.setEtat(reponse);
		try {
			formationS.update(Formation);
			session.setAttribute("message2", "le formation est bien accepte");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		sseService.getSsEmitters().forEach((SseEmitter emitter) -> {
            try {
                emitter.send("bonjour on'a un nouvel formation qui nom"+Formation.getName_formation(), MediaType.APPLICATION_JSON);
            } catch (IOException e) {
                emitter.complete();
                sseService.remove(emitter);
                e.printStackTrace();
            }
        });
		}else {
			System.out.println(formationS.deletFileById(idF));
			session.setAttribute("message2", "le formation est bien refuse");
		}
		return "redirect:/profile_etablissement";
	}
	@PostMapping(value = "/addcondidature/{idFormation}/{idFormateur}")
	public String addcon(@PathVariable("idFormation") String idFormation,@PathVariable("idFormateur") String idFormateur,HttpSession session) {
		long IDFormation=Long.parseLong(idFormation);
		long IDFormateur=Long.parseLong(idFormateur);
		Formation Formation=formationS.getFile(IDFormation);
		Formateur Formateur=formateurS.getFilebyId(IDFormateur);
		Etablissement appre = etablissementS.getFile((String) session.getAttribute("email"));
		Condidature Cond=new Condidature();
		Cond.setEtab(appre);
		Cond.setForm(Formation);
		Cond.setForma(Formateur);
		Cond.setEtat(false);
		Cond.setDemandeur(Etablissement.typet);
		try {
			condS.store(Cond);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/profile_etablissement";
	}
	@GetMapping(value = "/suppCondidature/{id_Cond}")
	public String addformation(@PathVariable("id_Cond") String id,HttpSession session) {
		long idF=Long.parseLong(id);

			System.out.println(condS.deletFileById(idF));
			session.setAttribute("message2", "le condidature est bien supprimer");
		return "redirect:/profile_etablissement";
	}
	@GetMapping(value = "/reponsecond/{reponse}/{id_condidature}")
	public String addcondidature(@PathVariable("reponse") boolean reponse,@PathVariable("id_condidature") String id,HttpSession session) {
		long idF=Long.parseLong(id);
		
		if(reponse) {
		Condidature Formation=condS.getFile(idF);
		Formation.setEtat(reponse);
		try {
			condS.store(Formation);
			session.setAttribute("message2", "le condidature est bien accepte");
			for (String email:apprenantService.emailsapprenant) {
				formationService.sendmail(email,Formation.getForm().getName_formation());
			}
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
			session.setAttribute("message2", "le condidature est bien refuse");
		}
		return "redirect:/profile_etablissement";
	}
	@PostMapping(value = "/addoffer/{idFormation}/{nomOffer}")
	public String addoffer(@PathVariable("idFormation") String id,@PathVariable("nomOffer") String nom,HttpSession session) {
		long ID=Long.parseLong(id);
		Offer offer=new Offer();
		offer.setNomeOffer(nom);
		offer.setFormation(formationS.getFile(ID));
		offer.setEtablissement(etablissementS.getFile((String) session.getAttribute("email")));
		offerS.store(offer);
		return "redirect:/profile_etablissement";
	}
	@GetMapping(value = "/deleteoffer/{id_Cond}")
	public String deleteoffer(@PathVariable("id_Cond") String id,HttpSession session) {
		long idF=Long.parseLong(id);

			System.out.println(offerS.deletbyid(idF));
			session.setAttribute("message2", "le condidature est bien supprimer");
		return "redirect:/profile_etablissement";
	}
	@GetMapping( "/deleteinscriptionetab/{id_Cond}")
	public String deleteinsc(@PathVariable("id_Cond") String id,HttpSession session) {
		long idF=Long.parseLong(id);
		System.out.println(inscS.deletFileById(idF));
		session.setAttribute("message2", "l'inscription est bien supprimer");
		return "redirect:/profile_etablissement";
	}


}
