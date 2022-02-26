<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>profile</title>
<link rel="stylesheet" href="/css/profile.css?version=51">
<script type="text/javascript" src="webjars/jquery/3.2.0/jquery.min.js"></script>
<script>
	$(document).ready(function () {
		$("#verifier").click(function () {
			$.post("/verifierpassetab", {
				pass: $("#pass").val()
			}, function (data, status) {
				if (data == true) {
					$("#verifierbox").css("display", "none");
					$("#changebox").css("display", "block");
					$("#infobar").css("paddingTop", "2%")

				} else {
					alert("votre mot de pass est incorrect");
				}
			});
		});
	});
	$(document).ready(function() {
		$("#condidature").click(function(){
			$("#formationbar").css("display","none");
			$("#infobar").css("display","none");
			$("#triterC").css("display","flex");
		});
	});
	$(document).ready(function() {
		$("#gerer").click(function(){
			$("#formationbar").css("display","flex");
			$("#infobar").css("display","none");
			$("#triterC").css("display","none");
		});
	});
	$(document).ready(function() {
		$("#info").click(function(){
			$("#formationbar").css("display","none");
			$("#infobar").css("display","block");
			$("#triterC").css("display","none");
		});
	});
	function showmodel(id){
		document.getElementById(id).style.display='block';
		return false;
		
	}
	function confirmation() {
		  
		  var r = confirm("êtes-vous sûr? ");
			return r;
		}
</script>
</head>

<body>


	<div id="toolbar">
		<svg xmlns="http://www.w3.org/2000/svg"
			xmlns:xlink="http://www.w3.org/1999/xlink" width="120" height="120"
			viewBox="0 0 120 120">
			<defs>
			<clipPath id="b">
			<rect width="120" height="120" /></clipPath></defs>
			<g id="a" clip-path="url(#b)">
			<circle cx="60" cy="60" r="60" fill="#fff" />
			<path
				d="M99.484,84.357C97.7,77.573,87.53,74.266,84.016,73.2c-3.861-1.173-9.355-1.451-12.894-2.134-2.029-.384-4.974-1.344-5.964-2.368s-.4-10.518-.4-10.518a30.515,30.515,0,0,0,2.821-4.63c.99-2.155,2.079-8.086,2.079-8.086s2.029,0,2.747-3.072c.767-3.35,1.98-4.651,1.831-7.147-.148-2.454-1.708-2.39-1.708-2.39s1.51-3.563,1.683-10.945C74.438,13.141,66.469,4.5,52.041,4.5c-14.626,0-22.422,8.641-22.2,17.409.2,7.382,1.658,10.945,1.658,10.945s-1.559-.064-1.708,2.39c-.148,2.5,1.064,3.8,1.831,7.147.693,3.072,2.747,3.072,2.747,3.072s1.089,5.931,2.079,8.086a30.515,30.515,0,0,0,2.821,4.63s.594,9.494-.4,10.518-3.935,1.984-5.964,2.368c-3.539.683-9.033.96-12.894,2.134C16.5,74.266,6.33,77.573,4.548,84.357A1.792,1.792,0,0,0,6.5,86.427h91.05A1.786,1.786,0,0,0,99.484,84.357Z"
				transform="translate(7.984 5.533)" /></g>
		        </svg>

		<p>bonjour etablisseur de <b>${name}</b></p>
		<button id="gerer">gerer les offers de formation</button>
		<button id="condidature">triter condidature</button>
		<button id="info">votre information</button>
		<form action="/logout" onsubmit="return confirmation()">
			<button formaction="/">retour a Acceuil</button>
			<button type="submit">désconnexion</button>
		</form>
	</div>
	<div id="formationbar">
		<div id="boxTriter" style="display: flex;flex-direction: row">
			<form id="formoffer" action="" onsubmit="return offer();" method="post" >
				<input type="text" placeholder="nom d'offre" id="nameOffer" >
				<select id="selectFormation" name="Formation" onchange="showFormation()" >
				<option value="null">nom de formation</option>
				<c:forEach var="Formation" items="${formationsaccepter}"><option value="${Formation.getId_formation()}">${Formation.getName_formation()}</option></c:forEach>
				</select>
				<button>offrir</button>
			</form>
		</div>
		<h1>Les offres</h1>
		<c:forEach var="Offer" items="${offers}">
			<div id="boxformation">
				
					<img src="${Offer.getFormation().getPhotosImagePath()}" alt="" >
					<p style="grid-area: info1">nom offer: ${Offer.getNomeOffer()}</p>
					<p style="grid-area: info2"> nom de formation: ${Offer.getFormation().getName_formation()} </p>
					<form  id="formformation" action="/deleteoffer/${Offer.getId_offer()}" onsubmit="return confirmation()">
					<a href="#" onclick="return showmodel('${Offer.getId_offer()}')" style="text-decoration: none;font-size: 1em;">More details</a>
					<button type="submit">supprimer</button>
					</form>	
			</div>
			<div id="${Offer.getId_offer()}" class="modal">
						<div class="modal-content animate">
							<div class="container">
								<h1>nom offer: ${Offer.getNomeOffer()}</h1>
								<h3>information de Formation </h3>
								<p>nom: <b>${Offer.getFormation().getName_formation()}</b></p>
								<p>prix: <b>${Offer.getFormation().getPrice()}</b></p>
								<p>niveau : <b>${Offer.getFormation().getNiveau()}</b></p>
								<p>	filier : <b>${Offer.getFormation().getFilier()}</b></p>
								<p>	duree :<b> ${Offer.getFormation().getDuree()}</b></p>
							</div>
							<img alt="formation" src="${Offer.getFormation().getPhotosImagePath()}" class="photo">
							<div class="container" style="background-color:#f1f1f1">
     			 				<button type="button" onclick="document.getElementById('${Offer.getId_offer()}').style.display='none'" class="cancelbtn">Cancel</button>
   		 					</div>
  						</div>
			</div>
		</c:forEach>
		<h1>Les Condidatures en attent</h1>
		<c:forEach var="Condidature" items="${condidaturesattent}">
			<div id="boxformation">
				
					<img src="${Condidature.getForm().getPhotosImagePath()}" alt="">
					<p> nom de formation: ${Condidature.getForm().getName_formation()} </p>
					<p> nom de Formateur :${Condidature.getForma().getFullname()}</p>
					<form  id="formformation" action="/reponsecond/true/${Condidature.getId_condidature()}" onsubmit="return confirmation()">
					<button type="submit">accept</button>
					<a href="#" onclick="return showmodel('condidature${Condidature.getId_condidature()}')" style="text-decoration: none;font-size: 1em;">More details</a>
					<button  formaction="/reponsecond/false/${Condidature.getId_condidature()}" onclick="return confirmation()">refuse</button>
					</form>	
			</div>
			<div id="condidature${Condidature.getId_condidature()}" class="modal">
						<div class="modal-content animate">
							<div class="container">
								<h3>information de Formateur </h3>
								<p>nom: <b>${Condidature.getForma().getFullname()}</b></p>
								<p>nom: <b>${Condidature.getForma().getEmail()}</b></p>
								<p>nom: <b>${Condidature.getForma().getCity()}</b></p>
								<p>nom: <b>${Condidature.getForma().getRegion()}</b></p>
								<p>nom: <b>${Condidature.getForma().getNomDeplom()}</b></p>
							</div>
							<img alt="formation" src="${Condidature.getForma().getPhotosImagePath()}" class="photo">
							<div class="container">
								<h3>information de formation </h3>
								<p>nom: <b>${Condidature.getForm().getName_formation()}</b></p>
								<p>prix: <b>${Condidature.getForm().getPrice()}</b></p>
								<p>niveau : <b>${Condidature.getForm().getNiveau()}</b></p>
								<p>	filier : <b>${Condidature.getForm().getFilier()}</b></p>
								<p>	duree :<b> ${Condidature.getForm().getDuree()}</b></p>
							</div>
							<img alt="formation" src="${Condidature.getForm().getPhotosImagePath()}" class="photo">
							<div class="container" style="background-color:#f1f1f1">
     			 				<button type="button" onclick="document.getElementById('condidature${Condidature.getId_condidature()}').style.display='none'" class="cancelbtn">Cancel</button>
   		 					</div>
  						</div>
			</div>
		</c:forEach>
		<h1>Les condidature deja accepter</h1>
		<c:forEach var="Condidature" items="${condidaturesaccepter}">
			<div id="boxformation">
				
					<img src="${Condidature.getForm().getPhotosImagePath()}" alt="">
					<p> nom de formation: ${Condidature.getForm().getName_formation()} </p>
					<p> nom de Formateur :${Condidature.getForma().getFullname()}</p>
					<form  id="formformation" action="/reponsecond/false/${Condidature.getId_condidature()}" onsubmit="return confirmation()">
					<a href="#" onclick="return showmodel('condidature${Condidature.getId_condidature()}')" style="text-decoration: none;font-size: 1em;">More details</a>
					<button type="submit">supprimer</button>
					</form>	
			</div>
			<div id="condidature${Condidature.getId_condidature()}" class="modal">
						<div class="modal-content animate">
							<div class="container">
								<h3>information de Formateur </h3>
								<p>nom: <b>${Condidature.getForma().getFullname()}</b></p>
								<p>nom: <b>${Condidature.getForma().getEmail()}</b></p>
								<p>nom: <b>${Condidature.getForma().getCity()}</b></p>
								<p>nom: <b>${Condidature.getForma().getRegion()}</b></p>
								<p>nom: <b>${Condidature.getForma().getNomDeplom()}</b></p>
							</div>
							<img alt="formation" src="${Condidature.getForma().getPhotosImagePath()}" class="photo">
							<div class="container">
								<h3>information de formation </h3>
								<p>nom: <b>${Condidature.getForm().getName_formation()}</b></p>
								<p>prix: <b>${Condidature.getForm().getPrice()}</b></p>
								<p>niveau : <b>${Condidature.getForm().getNiveau()}</b></p>
								<p>	filier : <b>${Condidature.getForm().getFilier()}</b></p>
								<p>	duree :<b> ${Condidature.getForm().getDuree()}</b></p>
							</div>
							<img alt="formation" src="${Condidature.getForm().getPhotosImagePath()}" class="photo">
							<div class="container" style="background-color:#f1f1f1">
     			 				<button type="button" onclick="document.getElementById('condidature${Condidature.getId_condidature()}').style.display='none'" class="cancelbtn">Cancel</button>
   		 					</div>
  						</div>
			</div>
		</c:forEach>
		<h1>Les inscriptions</h1>
		<c:forEach var="Inscriptions" items="${formations}">
			<div id="boxformation">
				<img src="${Inscriptions.getFormation().getPhotosImagePath()}" alt="">
				<p style="grid-area: info1"> name: ${Inscriptions.getFormation().getName_formation()}</p>
				<p style="grid-area: info2"> niveau : ${Inscriptions.getFormation().getNiveau()}</p>
				<p style="grid-area: info3"> filier : ${Inscriptions.getFormation().getFilier()}</p>
				<div style="grid-area: btn">
					<a  href="/deleteinscriptionetab/${Inscriptions.getId_insc()}" onclick="return myFunction()" style="text-decoration: none;font-size: 1em;grid-area: btn1">Suprimer</a>
					<a href="#" onclick="return showmodel('${Inscriptions.getId_insc()}')"
					   style="text-decoration: none;font-size: 1em;grid-area: btn2">More details</a>
				</div>
			</div>
			<div id="${Inscriptions.getId_insc()}" class="modal">
				<div class="modal-content animate">
					<div class="container">
						<p>information d'apprenant : </p> <br>
						<p>nom :<b>${Inscriptions.getApp().getFullname()}</b> email:
							<b>${Inscriptions.getApp().getEmail()}</b></p>
						<p>information de formation </p>
						<p><b>${Inscriptions.getFormation().getName_formation()}</b></p>
					</div>
					<img alt="" src="${Inscriptions.getFormation().getPhotosImagePath()}" class="photo">
					<div class="container">
						<p>information de formateur </p>
						<p>nom: <b>${Inscriptions.getForma().getFullname()}</b> email:
							<b>${Inscriptions.getForma().getEmail()}</b></p>
					</div>
					<img alt="" src="${Inscriptions.getForma().getPhotosImagePath()}" class="photo">
					<div class="container" style="background-color:#f1f1f1">
						<button type="button"
								onclick="document.getElementById('${Inscriptions.getId_insc()}').style.display='none'"
								class="cancelbtn">Cancel
						</button>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	<div id="infobar">
		<div id="verifierbox">
			<input type="password" placeholder="entre votre password pour verifier"
				   id="pass" style="margin-top: 30%"> <br>
			<button id="verifier" style="margin: 8% 25% 8% 25%">Verifier</button>
		</div>
		<div id="changebox" style="display: none">
			<form id="changeform" method="POST" onSubmit="return Validate();" style="padding: 5%">
				<input type="text" value="${name}" id="fullname" name="fullname" disabled>
				<a href="#" onclick="return changeinfo('fullname')" style="margin-bottom: 6%">change</a>

				<input type="text" value="${email}" id="email" name="email" disabled>
				<a href="#" onclick="return changeinfo('email')" style="margin-bottom: 6%">change</a> <br>

				<input type="password" value="${mdp}" id="password1" name="password" disabled>
				<a href="#" onclick="return changeinfo('password1')" style="margin-bottom: 6%">change</a>
				<input type="password" value="${mdp}" id="password2" disabled>
				<select name="city" id="city" disabled>
					<option value="${ville}">${ville}</option>
					<option value="ghardaia">ghardaia</option>
					<option value="constantine">constantine</option>
					<option value="khenchla">khenchla</option>
				</select>
				<a href="#" onclick="return changeinfo('city')" style="margin-bottom: 6%">change</a>
				<button type="submit" style="margin: 3% 25% 3% 25%;font-size: 1.4em;padding:2% 8%">changer</button>
			</form>
		</div>
	</div>
	<div id="triterC" style="display: none;">
		<div id="boxTriter">
			<form id="formtriter" action="" onsubmit="return triter();" method="post">
				<select name="Formateur" id="selectFormateur" onchange="showFormateur()">
				<option value="">nom de formateur</option>
				<c:forEach var="Formateur" items="${formateurs}"><option value="${Formateur.getId_formateur()}">${Formateur.getFullname()}</option></c:forEach>
				</select>
				<select id="selectFormation" name="Formation" onchange="showFormation()">
				<option value="null">nom de formation</option>
				<c:forEach var="Formation" items="${formationsaccepter}"><option value="${Formation.getId_formation()}">${Formation.getName_formation()}</option></c:forEach>
				</select>
				<button>triter</button>
			</form>
		</div>
		<c:forEach var="Formation" items="${formationsaccepter}">
			<div class="formationbox" id="${Formation.getId_formation()}" style="display: none;">
				
					<img alt="" src="${Formation.getPhotosImagePath()}">
					<p> nom de <b><b>Formation:</b></b>${Formation.getName_formation()} </p>
					<button type="submit" onclick="document.getElementById('cond${Formation.getId_formation()}').style.display='block'" style="width: auto;height: 40px;">afficher tout les informations</button>
			</div>
			<div id="cond${Formation.getId_formation()}" class="modal">
						<div class="modal-content animate">
							<div class="container">
								<p>information de Formation </p><br>
								<p>nom: <b>${Formation.getName_formation()}</b></p>
								<p>prix: <b>${Formation.getPrice()}</b></p>
								<p>niveau : <b>${Formation.getNiveau()}</b></p>
								<p>	filier : <b>${Formation.getFilier()}</b></p>
								<p>	duree :<b> ${Formation.getDuree()}</b></p>
							</div>
							<img alt="formation" src="${Formation.getPhotosImagePath()}" class="photo">
							<div class="container" style="background-color:#f1f1f1">
     			 				<button type="button" onclick="document.getElementById('cond${Formation.getId_formation()}').style.display='none'" class="cancelbtn">Cancel</button>
   		 					</div>
  						</div>
			</div>
		</c:forEach>
		<c:forEach var="Formateur" items="${formateurs}">
			<div class="formationbox" id="${Formateur.getId_formateur()}" style="display: none;width: 100%;">
				<img alt="" src="${Formateur.getPhotosImagePath()}">
				<p> nom de <b><b>Formateur:</b></b>:${Formateur.getFullname()} </p>
				<button onclick="document.getElementById('cond${Formateur.getId_formateur()}').style.display='block'"style="width: auto;height: 40px;">afficher tout les informations</button>
			</div>
			<div id="cond${Formateur.getId_formateur()}" class="modal">
						<div class="modal-content animate">
							<div class="container">
								<p>information de Formateur </p><br>
								<p>nom: <b>${Formateur.getFullname()}</b></p>
								<p>Email: <b>${Formateur.getEmail()}</b></p>
								<p>niveau : <b>${Formateur.getNiveau()}</b></p>
								<p>	City : <b>${Formateur.getCity()}</b></p>
								<p>	Region :<b> ${Formateur.getRegion()}</b></p>
								<p>Deplom</p>
							</div>
							<img alt="formation" src="${Formateur.getPhotosImagePath()}" class="photo">
							<div class="container" style="background-color:#f1f1f1">
     			 				<button type="button" onclick="document.getElementById('cond${Formateur.getId_formateur()}').style.display='none'" class="cancelbtn">Cancel</button>
   		 					</div>
  						</div>
			</div>
		</c:forEach>
		<h1>les condidatures deja accepter</h1>
		<c:forEach var="Condidature" items="${condidaturesaccepter}">
				<div id="boxformation">
				
					<img src="${Condidature.getForm().getPhotosImagePath()}" alt="">
					<p> nom de formation: ${Condidature.getForm().getName_formation()}</p>
					<p>nom de <b>Formateur</b>:${Condidature.getForma().getFullname()} </p>
					<form  id="formcondidature" action="/suppCondidature/${Condidature.getId_condidature()}" >
					<button >Supprimer</button>
					<a href="#" onclick="return showmodel(${Condidature.getId_condidature()})" style="text-decoration: none;font-size: 1em;">More details</a>
					
					</form>
				</div>
				<div id="${Condidature.getId_condidature()}" class="modal">
						<div class="modal-content animate">
							<div class="container">
								<p>information de formation </p><br>
								<p>nom: <b>${Condidature.getForm().getName_formation()}</b></p>
								<p>prix: <b>${Condidature.getForm().getPrice()}</b></p>
								<p>niveau : <b>${Condidature.getForm().getNiveau()}</b></p>
								<p>	filier : <b>${Condidature.getForm().getFilier()}</b></p>
								<p>	duree :<b> ${Condidature.getForm().getDuree()}</b></p>
							</div>
							<img alt="formation" src="${Condidature.getForm().getPhotosImagePath()}" class="photo">
							<div class="container">
								<p>information de formateur </p><br>
								<p>nom: <b>${Condidature.getForma().getFullname()}</b></p>
								<p>prix: <b>${Condidature.getForma().getEmail()}</b></p>
								<p>niveau : <b>${Condidature.getForma().getNiveau()}</b></p>
								<p>	City : <b>${Condidature.getForma().getCity()}</b></p>
								<p>	Region :<b> ${Condidature.getForma().getRegion()}</b></p>
							</div>
							<img alt="formation" src="${Condidature.getForma().getPhotosImagePath()}" class="photo">
							<div class="container" style="background-color:gray">
     			 				<button type="button" onclick="document.getElementById('${Condidature.getId_condidature()}').style.display='none'" class="cancelbtn">Cancel</button>
   		 					</div>
  						</div>
				</div>	
		</c:forEach>
	</div>
	<script lang="JavaScript">
		function offer(){
			var x=document.getElementById('selectFormation').value;
			var y=document.getElementById('nameOffer').value;
			var z=document.getElementById('formoffer');
			z.action="/addoffer/"+x+"/"+y;
		}
		function triter(){
			var x=document.getElementById('selectFormation').value;
			var y=document.getElementById('selectFormateur').value;
			var z=document.getElementById('formtriter');
			z.action="/addcondidature/"+x+"/"+y;
		}
		function showFormation(){
			var x=document.getElementById('selectFormation').value;
			var y=document.getElementById(x);
			y.style.display='flex';
		}
		function showFormateur(){
			var x=document.getElementById('selectFormateur').value;
			var y=document.getElementById(x);
			y.style.display='flex';
		}
		function Validate() {
			var password = document.getElementById('password1');
			var confirmPassword = document.getElementById('password2');
			var form = document.getElementById('changeform');
			if (password.value != confirmPassword.value) {
				confirmPassword.style.borderColor = 'red';
				alert("Passwords do not match.");
				return false;
			}else{
				var a = document.getElementById('password1');
				var b = document.getElementById('fullname');
				var c = document.getElementById('email');
				var d = document.getElementById('city');
				a.disabled=false;
				b.disabled=false;
				c.disabled=false;
				d.disabled=false;
				form.action="/changeinfoetab";
				return true;
			}
		}
		function changeinfo(id) {
            if (id == 'password1') {
                var x = document.getElementById(id);
                var y = document.getElementById('password2')
                x.style.backgroundColor = 'white';
                y.style.backgroundColor = 'white';
                x.disabled = false
                y.disabled = false
            }
            var x = document.getElementById(id);
            x.disabled = false
            x.style.backgroundColor = 'white';
        }
		function changebox(id1, id2) {
			var x = document.getElementById(id1);
			x.style.display = 'none';
			var x = document.getElementById(id2);
			if (id2 == 'infobar') {
				x.style.display = 'block';
			} else {
				x.style.display = 'flex';
			}
		}
</script>
</body>

</html>