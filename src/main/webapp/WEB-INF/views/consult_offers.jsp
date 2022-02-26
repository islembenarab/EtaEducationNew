<%@page import="formatec.DAO.Formation"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/css/consult.css?version=51">
</head>

<body>
    <header>
        <p>notre Offers</p>
    </header>
<%@page import="java.util.List"%>
    <div id="listoffers">
    <c:forEach var="Offer" items="${offers}">
        <div>
        	<form action="/demandecond/${Offer.getEtablissement().getId_etablissement()}/${Offer.getFormation().getId_formation()}" id="formdemande" >
        	<h1>${Offer.getNomeOffer()}</h1>
        	<h3>${Offer.getFormation().getName_formation()}</h3>
        	<input id="id" type="text" value="${url_button_demande}" style="display: none">
            <img src="${Offer.getFormation().getPhotosImagePath()}" alt="">
            <button type="submit" id="btnDemande">${button_demande}</button>
			<a href="#" onclick="return showmodel('${Offer.getId_offer()}')" style="text-decoration: none;font-size: 1em;"><b>plus details</b></a>    
			</form>
    	</div>
      <div id="${Offer.getId_offer()}" class="modal">
						<div class="modal-content animate">
								<h1 style="margin-top:5%;font-size: 2em">${Offer.getNomeOffer()}</h1>
								<p>information de etablissement </p>
								<p>nom: <b>${Offer.getEtablissement().getFullname()}</b></p>
								<p>email: <b>${Offer.getEtablissement().getEmail()}</b></p>
								<p>ville: <b>${Offer.getEtablissement().getCity()}</b></p>
								<p>Region: <b>${Offer.getEtablissement().getRegion()}</b></p>
								<h1>information de formation</h1>
								<p>nom: <b>${Offer.getFormation().getName_formation()}</b></p>
								<p>prix: <b>${Offer.getFormation().getPrice()}</b></p>
								<p>niveau : <b>${Offer.getFormation().getNiveau()}</b></p>
								<p>	filier : <b>${Offer.getFormation().getFilier()}</b></p>
								<p>	duree :<b> ${Offer.getFormation().getDuree()}</b></p>
								<img alt="formation" src="${Offer.getFormation().getPhotosImagePath()}" class="photo">	
     			 				<button type="button" onclick="document.getElementById('${Offer.getId_offer()}').style.display='none'" class="cancelbtn">Cancel</button>
  						</div>
		</div>
     </c:forEach>
    </div>
	
<script type="text/javascript">
		function showmodel(id){
			document.getElementById(id).style.display='inline';
			return false;
			}
		function demande(){
			var x=document.getElementById("btnDemande").value;
			var y=document.getElementById("formdemande");
			if(x=="/sign_in"){
				y.action="/sign_in";
			}else{
				var z=document.getElementById("id").value;
				y.action=z;
			}
			return true;
		}
</script>
</body>

</html>