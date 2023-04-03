package formatec.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.paypal.api.payments.Links;
import com.paypal.api.payments.Payment;
import com.paypal.base.rest.PayPalRESTException;

import formatec.DAO.Apprenant;
import formatec.DAO.Condidature;
import formatec.DAO.Inscriptions;
import formatec.DAO.payment;
import formatec.service.*;
@RestController
public class apprenant_controller {
	@Autowired
	apprenantService apprenantS;
	@Autowired
	formationService formationS;
	@Autowired
	inscriptionsService inscS;
	@Autowired
	paymentService payS;
	@Autowired
	condidatureService CondS;
	@Autowired
	SseServiceImpl sseService;

	@GetMapping(value = "/profile_apprenant")
	public String profile_app(Model model, HttpSession session) {
		if(session.getAttribute("logged")==null)
			return"redirect:/sign_in";
		model.addAttribute("name", session.getAttribute("name"));
		Apprenant app = apprenantS.getFile((String) session.getAttribute("email"));
		model.addAttribute("email", app.getEmail());
		model.addAttribute("name", app.getFullname());
		model.addAttribute("mdp",app.getPassword());
		model.addAttribute("ville", app.getCity());
		model.addAttribute("formations",inscS.getAllFilesByIdApp(app));
		SseEmitter apprenantemitter = new SseEmitter();
        sseService.add(apprenantemitter);
        apprenantemitter.onCompletion(() -> sseService.remove(apprenantemitter));
		return "profile_apprenant";
	}

	@PostMapping(value = "/verifierpass")
	@ResponseBody
	public boolean verifier(String pass, HttpSession session, Model model) {

		if (apprenantS.getFile((String) session.getAttribute("email")).getPassword().equals(pass)) {
			
			return true;
		}
		return false;
	}
	@PostMapping(value = "/changeinfo")
	public String change(@ModelAttribute("apprenant")Apprenant app, HttpSession session) {
		System.out.println(app.getEmail()+app.getFullname()+app.getCity()+app.getPassword());
		Apprenant appre = apprenantS.getFile((String) session.getAttribute("email"));
		appre.setEmail(app.getEmail());
		appre.setFullname(app.getFullname());
		appre.setCity(app.getCity());
		appre.setPassword(app.getPassword());
		try {
			apprenantS.update(appre);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return"redirect:/logout";
	}
	@GetMapping(value = "/payment/{id}")
	public String pay(Model model,@PathVariable("id") String idCond,HttpSession session) {
		if(session.getAttribute("logged")==null)
			return"redirect:/sign_in";
		if(session.getAttribute("email").equals("islemapp@gmail.com")){
			long ID=Long.parseLong(idCond);
			Apprenant app=apprenantS.getFile((String) session.getAttribute("email"));
			Condidature cond=CondS.getFile(ID);
			Inscriptions insc=new Inscriptions();
			insc.setApp(app);
			insc.setForma(cond.getForma());
			insc.setFormation(cond.getForm());
			insc.setEtab(cond.getEtab());
			try {
				inscS.store(insc);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return "redirect:/profile_apprenant";
		}else {
		model.addAttribute("id_condidature", idCond);
		long ID=Long.parseLong(idCond);
		model.addAttribute("price", CondS.getFile(ID).getForm().getPrice());
		return "payment";
		}
	}
	@PostMapping (value = "/pay/{id}")
	public String DoPay(@ModelAttribute("payment")payment pay,@PathVariable("id") String id,HttpSession session) {
		long ID=Long.parseLong(id);
		session.setAttribute("id_condidature", ID);
		try {
			Apprenant app=apprenantS.getFile((String) session.getAttribute("email"));
			Condidature cond=CondS.getFile(ID);
			Inscriptions insc=new Inscriptions();
			insc.setApp(app);
			insc.setForma(cond.getForma());
			insc.setFormation(cond.getForm());
			insc.setEtab(cond.getEtab());
			Payment payment = payS.createPayment(cond.getForm().getPrice(), pay.getCurrency(), pay.getMethod(),
				pay.getIntent(), pay.getDiscription(), "http://localhost:8080/cancel",
					"http://localhost:8080/success");
			for(Links link:payment.getLinks()) {
				if(link.getRel().equals("approval_url")) {
					return "redirect:"+link.getHref();
				}
			}

		} catch (PayPalRESTException e) {

			e.printStackTrace();
		}
		return "redirect:/";
	}
	 @GetMapping(value = "/cancel")
	    public String cancelPay(HttpSession session) {
		 	session.setAttribute("message2", "votre payment est bien recu");
	        return "redirect:/profile_apprenant";
	    }

	    @GetMapping(value = "/success")
	    public String successPay(@RequestParam("paymentId") String paymentId, @RequestParam("PayerID") String payerId,HttpSession session) {
	        try {
	            Payment payment = payS.executePayment(paymentId, payerId);
	            System.out.println(payment.toJSON());
	            if (payment.getState().equals("approved")) {
	            	Apprenant app=apprenantS.getFile((String) session.getAttribute("email"));
	    			Condidature cond=CondS.getFile((long)session.getAttribute("id_condidature"));
	    			Inscriptions insc=new Inscriptions();
	    			insc.setApp(app);
	    			insc.setForma(cond.getForma());
	    			insc.setFormation(cond.getForm());
	    			insc.setEtab(cond.getEtab());
	    			inscS.store(insc);
	                return "success";
	            }
	        } catch (PayPalRESTException | IOException e) {
	         System.out.println(e.getMessage());
	        }
	        session.setAttribute("message2", "votre payment est bien recu");
	        return "redirect:/profile_apprenant";
	    }
	    @GetMapping("/deleteinscription/{id}")
		public String deleteinsc(@PathVariable("id")String Id){
			long ID=Long.parseLong(Id);
			inscS.deletFileById(ID);
			return "redirect:/profile_apprenant";
		}

}
