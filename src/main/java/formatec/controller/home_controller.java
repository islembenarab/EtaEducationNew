package formatec.controller;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import formatec.DAO.Formateur;
import formatec.repository.SseService;
import formatec.DAO.Admin;
import formatec.DAO.Apprenant;
import formatec.DAO.Etablissement;
import formatec.service.OfferService;
import formatec.service.adminService;
import formatec.service.apprenantService;
import formatec.service.condidatureService;
import formatec.service.etablissementService;
import formatec.service.formateurService;
import formatec.service.formationService;

@Controller
public class home_controller {
	@Autowired
	apprenantService apprenantS;
	@Autowired
	formateurService formateurS;
	@Autowired
	etablissementService etablissementS;
	@Autowired
	formationService formationS;
	@Autowired
	adminService adminS;
	@Autowired
	condidatureService condS;
	@Autowired
	OfferService offerS;
	@Autowired
	SseService sseService;
	

	@GetMapping(value = "/")
	public String home(Model model, HttpSession session) {
		System.out.println("-------------------------------------------------------------------------------------");
		if(adminS.getFile("benarab2000@gmail.com")==null) {
			Admin adm = new Admin();
			adm.setEmail("benarab2000@gmail.com");
			adm.setFullname("benarab islem");
			adm.setPassword("islem");
			
			try {
				adminS.store(adm);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
			
		if (session.getAttribute("logged")==null) {
			model.addAttribute("url_signin", "/sign_in");
			model.addAttribute("url_signup", "/Sign_up");
			model.addAttribute("url_signup2", "/consultoff");
			model.addAttribute("url_button_consult", "/consultform/all/all/all");
			model.addAttribute("button_signin", "Se connect");
			model.addAttribute("button_consult", "consulter formations");
			model.addAttribute("button_signup", "Inscrit");
			model.addAttribute("button_signup2", "consulter offers");
			model.addAttribute("message",session.getAttribute("message"));
		} else {
			if("/profile_apprenant".equalsIgnoreCase((String)session.getAttribute("url_profile"))) {
				model.addAttribute("button_consult", "consulter formations");
				model.addAttribute("url_button_consult", "/consultform/all/all/all");
			}else {
				if("/profile_formateur".equalsIgnoreCase((String)session.getAttribute("url_profile"))) {
					model.addAttribute("button_consult", "consulter offers");
					model.addAttribute("url_button_consult", "/consultoff");
				}else {
					model.addAttribute("button_consult", "Deconnecter");
					model.addAttribute("url_button_consult", "/logout");
				}
			}
			model.addAttribute("url_signin", "/logout");
			model.addAttribute("url_signup", session.getAttribute("url_profile"));
			model.addAttribute("url_signup2", session.getAttribute("url_profile"));
			model.addAttribute("button_signin", "Log out");
			model.addAttribute("button_signup", "hi " + session.getAttribute("name"));
			model.addAttribute("button_signup2", "Go to your profile");
		}
		return "home.jsp";
	}

	@GetMapping(value = "/logout")
	public String logout(HttpSession session) {
		
		session.invalidate();
		return "redirect:/";
	}

	@GetMapping(value = "/sign_in")
	public String sign_in(HttpSession session,Model model) {
		session.setAttribute("message", "");
		model.addAttribute("messagelogin",session.getAttribute("messagelogin"));
		return "sign_in";
	}

	@GetMapping(value = "/Sign_up")
	public String Sign_up(HttpSession session) {
		session.setAttribute("message", "");
		return "Sign_up";
	}

	@GetMapping(value = "/consultform/{idEtab}/{category}/{content}")
	public String consultform(@PathVariable("idEtab")String idEtab,@PathVariable("category")String category
			,@PathVariable("content")String content,HttpSession session,Model model) {
		
		if (session.getAttribute("logged")==null) {
			model.addAttribute("url_button_buy", "/sign_in");
			model.addAttribute("button_buy","Se connect");
		}else {
			model.addAttribute("button_buy","Achter");
			model.addAttribute("url_button_buy", "/payment/${condidature.getId_condidature()}");
		}
		model.addAttribute("allformation",condS.getAllFilesByetat(true)) ;
		
		if(idEtab.equals("all")&&(category.equals("all")||(content.equals("all")))) {
			model.addAttribute("alletabs",etablissementS.getAllFiles());
		}else {
			if(!idEtab.equals("all")) {
			model.addAttribute("alletabs",etablissementS.getAllFiles());
			long idetab=Long.parseLong(idEtab);
			model.addAttribute("allformation",condS.getAllFilesByetatAndetab(true,etablissementS.getFilebyId(idetab)));	
			}else {
				List<Etablissement> listetab=etablissementS.getAllFiles();
				{
					switch (category) {
					case "region": {
						model.addAttribute("alletabs",listetab.stream().filter(e-> e.getRegion().equalsIgnoreCase(content)).collect(Collectors.toList()));
						break;
					}
					case "city": {
						model.addAttribute("alletabs",listetab.stream().filter(e-> e.getCity().equalsIgnoreCase(content)).collect(Collectors.toList()));
						break;
					}
					case "Filiere": {
						model.addAttribute("alletabs",listetab.stream().filter(e-> e.getNomDeplom().equalsIgnoreCase(content)).collect(Collectors.toList()));
						break;
					}
					case "Niveau": {
						int Content=Integer.parseInt(content);
						model.addAttribute("alletabs",listetab.stream().filter(e-> e.getNiveau()==Content).collect(Collectors.toList()));
						break;
					}
					default:
						throw new IllegalArgumentException("Unexpected value: " + category);
					}
				}
			}
		}
		return "consult_form";
	}
	@GetMapping(value = "/consultoff")
	public String consultoff(ModelMap model,HttpSession session) {
		if (session.getAttribute("logged")==null) {
			model.addAttribute("url_button_demande", "/sign_in");
			model.addAttribute("button_demande","se connect avec un formateur");
		}else {
			model.addAttribute("button_demande","demander une condidature");
			model.addAttribute("url_button_demande", "/demandecond/${Offer.getEtablissement().getId_etablissement()}/${Offer.getFormation().getId_formation()}");
		}
		model.addAttribute("offers", offerS.getAllfile());
		return "consult_offers";
	}

	@PostMapping(value = "/authentify")
	public String authentify(@RequestParam("email")String email,@RequestParam("password")String password, @RequestParam("type") String type,@RequestParam(required = false,value = "remember") String remember,
			HttpSession session) {
		if (session.getAttribute("time")==null)
				session.setAttribute("time", 1);
		while ((int) session.getAttribute("time") < 3) {
			if((type.equals(Admin.typead))&&(adminS.authentify(email,password))) {
				if(remember=="true")
					session.setMaxInactiveInterval(60*60*24*7);
				session.setAttribute("url_profile", "/profile_admin");
				session.setAttribute("email", email);
				session.setAttribute("name", adminS.getFile(email).getFullname());
				session.setAttribute("logged", true);
				return "redirect:/profile_admin";
			}else {
			if (((type.equals(Apprenant.typea))&&(apprenantS.authentify(email,password)))&&(apprenantS.getFile(email).isEtat())){
				if(remember=="true")
					session.setMaxInactiveInterval(60*60*24*7);
				session.setAttribute("url_profile", "/profile_apprenant");
				session.setAttribute("email", email);
				session.setAttribute("name", apprenantS.getFile(email).getFullname());
				session.setAttribute("logged", true);
				return "redirect:/profile_apprenant";
			} else {
				if (((type.equals(Formateur.typef)) && (formateurS.authentify(email,password)))&&(formateurS.getFile(email).isEtat())) {
					if(remember=="true")
						session.setMaxInactiveInterval(60*60*24*7);
					session.setAttribute("url_profile", "/profile_formateur");
					session.setAttribute("email", email);
					session.setAttribute("name", formateurS.getFile(email).getFullname());
					session.setAttribute("logged", true);
					return "redirect:/profile_formateur";
				} else {
					if ((etablissementS.authentify(email,password))&&(etablissementS.getFile(email).isEtat())) {
						if(remember=="true")
							session.setMaxInactiveInterval(60*60*24*7);
						session.setAttribute("url_profile", "/profile_etablissement");
						session.setAttribute("email", email);
						session.setAttribute("name", etablissementS.getFile(email).getFullname());
						session.setAttribute("logged", true);
						return "redirect:/profile_etablissement";
					}else {
						session.setAttribute("messagelogin","verifier votre informations");
						session.setAttribute("time", (int) session.getAttribute("time") + 1);
						return "redirect:/sign_in";
					}
				}

			}
		}}
		session.invalidate();
		return "redirect:/";
	}

	@PostMapping(value = "/adduser")
	public String add(@ModelAttribute("apprenant") Apprenant app, @ModelAttribute("formateur") Formateur form,
			@ModelAttribute("etablissement") Etablissement etab, @RequestParam("type") String type,@RequestParam MultipartFile file, HttpSession session
			)
			throws IOException {
		if ((type.equals(Apprenant.typea))) {
			app.setEtat(false);
			apprenantS.store(app,file);
			String uploaddir = "allphoto/apprenants/" + app.getEmail();
			formateurService.saveFile(uploaddir, apprenantS.getFile(app.getEmail()).getDeplom(), file);
			session.setAttribute("message", "votre compt est bien cree svp se connecter en authentification");
			return "redirect:/";
		} else {
			if ((type.equals(Formateur.typef))) {
				form.setEtat(false);
				formateurS.store(form,file);
				String uploaddir = "allphoto/formateurs/" + form.getEmail();
				formateurService.saveFile(uploaddir, formateurS.getFile(form.getEmail()).getDeplom(), file);
				session.setAttribute("message", "votre compt est bien cree svp se connecter en authentification");			
				return "redirect:/";
			} else {
				etab.setEtat(false);
				etablissementS.store(etab,file);
				String uploaddir = "allphoto/etablissements/" + etab.getEmail();
				formateurService.saveFile(uploaddir, etablissementS.getFile(etab.getEmail()).getDeplom(), file);
				session.setAttribute("message", "votre compt est bien cree svp se connecter en authentification");
				return "redirect:/";
			}
		}

	}

}
