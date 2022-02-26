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
	    <link rel="stylesheet" type="text/css" href="/css/consult.css?version=51">
	</head>
	
	<body >
	    <header style="margin-bottom: 2%">
	        <a href="/" style="margin-right: 50px;"><img alt="" src="/img/logo.png"></a>
	        <p>Notre ecoles</p>
	        <form action="/"  onsubmit="return filter();" id="formFilter">
	        <select name="" id="category" onchange="niveauchamp()">
	        <option value="all">Category</option>
	        <option value="region">region</option>
	        <option value="city">city</option>
	        <option value="Filiere">Filiére</option>
	        <option value="Niveau">Niveau</option>
	    	</select>
	    	<select name="" id="niveau"  style="display: none;">
	            <option value="" >niveau du education</option>
	            <option value="1" >1 anne primier</option>
	            <option value="2" >2 anne primier</option>
	            <option value="3" >3 anne primier</option>
	            <option value="4" >4 anne primier</option>
	            <option value="5" >5 anne primier</option>
	            <option value="6" >1 anne moyenne</option>
	            <option value="7" >2 anne moyenne</option>
	            <option value="8" >3 anne moyenne</option>
	            <option value="9" >4 anne moyenne</option>
	            <option value="10" >1 anne secondaire</option>
	            <option value="11" >2 anne secondaire</option>
	            <option value="12" >3 anne secondaire</option>
	            <option value="13" >admit en bac</option>
	            <option value="14" >1 anne unversaire</option>
	            <option value="15" >2 anne unversaire</option>
	            <option value="16" >3 anne unversaire</option>
	            <option value="17" >1 anne unversaire Master</option>
	            <option value="18" >2 anne unversaire Master</option>
	        </select>
	        <input type="text" id="content" value="all">
	        <button type="submit">Filter</button>
	        </form>
	    </header>
	    <div class="listetab">
	       <div>
	        	<form action="/consultform/all/all/all">
	            	<p><b>Tout</b></p>
	            	<p><b>les</b> </p>
	            	<p><b>ecoles</b></p>
	            	<button>consulter leur formation</button>
				</form>
	        </div>
	    <c:forEach var="Etablissement" items="${alletabs}">
	        <div>
	        	<form action="/consultform/${Etablissement.getId_etablissement()}/all/all">
	            	<p>nom: <b>${Etablissement.getFullname()}</b></p>
	            	<p> email:<b>${Etablissement.getEmail()}</b></p>
	            	<p>ville:<b>${Etablissement.getCity()}</b></p>
	            	<button>consulter leur formation</button>
				</form>
	        </div>
	      </c:forEach>
	
	    </div>
	    <header style="margin:0; padding: 0;">
	    <p style="margin:0; padding: 0;">Notre fomration</p>
	    </header>
	<%@page import="java.util.List"%>
	    <div class="listformation" style="margin-bottom: 0">
	    <c:forEach var="Condidature" items="${allformation}">
	        <div>
	        <form action="/payment/${Condidature.getId_condidature()}"  >
	            <img src="${Condidature.getForm().getPhotosImagePath()}" alt="">
	            <p><b>Formation: ${Condidature.getForm().getName_formation()}</b></p>
	            <input id="id" type="text" value="/payment/${Condidature.getId_condidature()}" style="display: none">
	            <button type="submit" id="btnDemande"value="${url_button_buy}">${button_buy}</button>
				<a href="#" onclick="return showmodel('${Condidature.getId_condidature()}')" style="text-decoration: none;font-size: 1em;"><b>plus details</b></a>
			</form>	
	        </div>
	    	     <div id="${Condidature.getId_condidature()}" class="modal">
							<div class="modal-content animate">
									<p>information de formation </p><br>
									<p>nom: <b>${Condidature.getForm().getName_formation()}</b></p>
									<p>prix: <b>${Condidature.getForm().getPrice()}</b></p>
									<p>niveau : <b>${Condidature.getForm().getNiveau()}</b></p>
									<p>	filier : <b>${Condidature.getForm().getFilier()}</b></p>
									<p>	duree :<b> ${Condidature.getForm().getDuree()}</b></p>
									<img alt="formation" src="${Condidature.getForm().getPhotosImagePath()}" class="photo">
									<p>information de formateur </p><br>
									<p>nom: <b>${Condidature.getForma().getFullname()}</b></p>
									<p>prix: <b>${Condidature.getForma().getEmail()}</b></p>
									<p>niveau : <b>${Condidature.getForma().getNiveau()}</b></p>
									<p>	ville : <b>${Condidature.getForma().getCity()}</b></p>
									<p>	Region :<b> ${Condidature.getForma().getRegion()}</b></p>
									<img alt="formation" src="${Condidature.getForma().getPhotosImagePath()}" class="photo">
									<p>information de etablissement </p>
									<p>nom: <b>${Condidature.getEtab().getFullname()}</b></p>
									<p>ville: <b>${Condidature.getEtab().getCity()}</b></p>
									<p>email: <b>${Condidature.getEtab().getEmail()}</b></p>	
	     			 				<button type="button" onclick="document.getElementById('${Condidature.getId_condidature()}').style.display='none'" class="cancelbtn">Cancel</button>
	  						</div>
				</div>
	     </c:forEach>
	    </div>
	 
	<script type="text/javascript">
			function showmodel(id){
				document.getElementById(id).style.display='inline';
				return false;
				}
			function niveauchamp(){
				if(document.getElementById("category").value=="Niveau"){
					document.getElementById("niveau").style.display="inline";
					document.getElementById("content").style.display="none";
				}else{
					document.getElementById("niveau").style.display="none";
					document.getElementById("content").style.display="inline";

				}
			}
			function filter(){
				var y=document.getElementById("category").value
				if(y=="Niveau"){
					var x=document.getElementById("niveau").value;
					var z=document.getElementById("formFilter");
					z.action="/consultform/all/"+y+"/"+x;
				}else{
					var x=document.getElementById("content").value;
					var z=document.getElementById("formFilter");
					z.action="/consultform/all/"+y+"/"+x;
				}
				return true;
			}
	</script>
	</body>
	
	</html>