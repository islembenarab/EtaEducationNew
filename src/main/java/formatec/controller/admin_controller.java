package formatec.controller;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.persistence.EntityManager;
import javax.servlet.http.HttpSession;

import formatec.repository.OfferRepository;
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

import formatec.DAO.*;
import formatec.service.*;
@Controller
public class admin_controller {
	@Autowired
	adminService adminS;
	@Autowired
	apprenantService apprenantS;
	@Autowired
	formationService formationS;
	@Autowired
	formateurService formateurS;
	@Autowired
	etablissementService etablissementS;
	@Autowired
	inscriptionsService inscS;
	@Autowired
	SseServiceImpl sseService;
	@Autowired
	condidatureService conS;
	@Autowired
	OfferRepository offerR;

	@GetMapping(value = "/profile_admin")
	public String profile_app(Model model, HttpSession session) {
		if(session.getAttribute("logged")==null)
			return"redirect:/sign_in";
		model.addAttribute("name", session.getAttribute("name"));
		Admin app = adminS.getFile((String) session.getAttribute("email"));
		model.addAttribute("email", app.getEmail());
		model.addAttribute("name", app.getFullname());
		model.addAttribute("mdp",app.getPassword());
		model.addAttribute("formationsaccepter", formationS.getAllFilesbyEtat(true));
		model.addAttribute("formationsattent", formationS.getAllFilesbyEtat(false));
		model.addAttribute("formateursaccepter", formateurS.getAllFilesByEtat(true));
		model.addAttribute("formateursattent", formateurS.getAllFilesByEtat(false));
		model.addAttribute("apprenantsattent", apprenantS.getAllFilesByetat(false));
		model.addAttribute("apprenantsaccepter", apprenantS.getAllFilesByetat(true));
		model.addAttribute("etablissementsattent", etablissementS.getAllFilesByEtat(false));
		model.addAttribute("etablissementsaccepter", etablissementS.getAllFilesByEtat(true));
		model.addAttribute("formations",inscS.getAllFiles());
		sseService.getSsEmitters().forEach((SseEmitter emitter) -> {
            try {
                emitter.send("bonjour on'a un nouvel formation qui nom", MediaType.APPLICATION_JSON);
            } catch (IOException e) {
                emitter.complete();
                sseService.remove(emitter);
                e.printStackTrace();
            }
        });
		return "profile_admin";
	}

	@PostMapping(value = "/verifierpassadmin")
	@ResponseBody
	public boolean verifier(String pass, HttpSession session, Model model) {

		if (adminS.getFile((String) session.getAttribute("email")).getPassword().equals(pass)) {
			
			return true;
		}
		return false;
	}
	@PostMapping(value = "/changeAdminInfo")
	public String change(@ModelAttribute("admin")Admin app, HttpSession session) {
		
		Admin appre = adminS.getFile((String) session.getAttribute("email"));
		appre.setEmail(app.getEmail());
		appre.setFullname(app.getFullname());
		appre.setPassword(app.getPassword());
		try {
			adminS.store(appre);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return"redirect:/logout";
	}
	@GetMapping(value = "/add/{type}/{Reponse}/{id}")
	public String add(@PathVariable("type") String type,@PathVariable("Reponse") boolean reponse,@PathVariable("id")String id) throws IOException, AddressException, MessagingException {
		long ID=Long.parseLong(id);
		if(type.equalsIgnoreCase("apprenant")) {
			Apprenant app= apprenantS.getFilebyId(ID);
			if(reponse) {
				app.setEtat(reponse);
				apprenantService.emailsapprenant.add(app.getEmail());
				adminService.sendmail(app.getEmail(), app.getFullname(), reponse);
				apprenantS.update(app);
			}else {
				adminService.sendmail(app.getEmail(), app.getFullname(), reponse);
				for (Inscriptions insc : inscS.getAllFilesByIdApp(app)) {
					inscS.deletFileById(insc.getId_insc());
				}
				apprenantS.deletFileById(app.getId_apprenant());
			}
		}else {
			if(type.equalsIgnoreCase("formateur")) {
				Formateur app= formateurS.getFilebyId(ID);
				if(reponse) {
					app.setEtat(reponse);
					adminService.sendmail(app.getEmail(), app.getFullname(), reponse);
					formateurS.update(app);
				}else {
					adminService.sendmail(app.getEmail(), app.getFullname(), reponse);
					for (Inscriptions insc:inscS.getAllFilesByIdformateur(app)) {
						inscS.deletFileById(insc.getId_insc());
					}
					for (Condidature insc:conS.getAllFilesByIdFormateur(app)) {
						conS.deletFileById(insc.getId_condidature());
					}
					System.out.println(formateurS.deletFileById(ID));
				}
			}else {
				if(type.equalsIgnoreCase("formation")) {
					Formation app= formationS.getFile(ID);
					if(reponse) {
						app.setEtat(reponse);
						formationS.update(app);
					}else {
						for (Inscriptions insc:inscS.getAllFilesByIdformation(app)) {
							inscS.deletFileById(insc.getId_insc());
						}
						for (Condidature insc:conS.getAllFilesByIdFormation(app)) {
							conS.deletFileById(insc.getId_condidature());
						}
						for (Offer offer:offerR.findAllByFormation(app)) {
							offerR.deleteById(offer.getId_offer());
						}
						System.out.println(formationS.deletFileById(app.getId_formation()));
					}
				}else {
					Etablissement app= etablissementS.getFilebyId(ID);
					if(type.equalsIgnoreCase("Etablissement")) {
						if(reponse) {
							app.setEtat(reponse);
							adminService.sendmail(app.getEmail(), app.getFullname(), reponse);
							etablissementS.update(app);
						}else {
							adminService.sendmail(app.getEmail(), app.getFullname(), reponse);
							for (Inscriptions insc:inscS.getAllFilesByIdetablissement(app)) {
								inscS.deletFileById(insc.getId_insc());
							}
							for (Condidature insc:conS.getAllFilesByIdEtab(app)) {
								conS.deletFileById(insc.getId_condidature());
							}
							for (Offer offer:offerR.findAllByEtablissement(app)) {
								offerR.deleteById(offer.getId_offer());
							}
							System.out.println(etablissementS.deletFileById(app.getId_etablissement()));
						}
					}
				}
			}
		}
		return "redirect:/profile_admin";
	}
	@GetMapping( "/deleteinscriptionadmin/{id}")
	public String deleteinsc(@PathVariable("id") String id,HttpSession session) {
		long idF=Long.parseLong(id);
		System.out.println(inscS.deletFileById(idF));
		session.setAttribute("message2", "l'inscription est bien supprimer");
		return "redirect:/profile_etablissement";
	}


}
