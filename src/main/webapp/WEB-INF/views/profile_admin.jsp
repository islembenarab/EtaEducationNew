<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
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
                $.post("/verifierpassadmin", {
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
    </script>
</head>

<body>
<div id="toolbar">
    <svg class="iconprofile" xmlns="http://www.w3.org/2000/svg"
         xmlns:xlink="http://www.w3.org/1999/xlink" width="120" height="120"
         viewBox="0 0 120 120">
        <defs>
            <clipPath id="b">
                <rect width="120" height="120"/>
            </clipPath>
        </defs>
        <g id="a" clip-path="url(#b)">
            <circle cx="60" cy="60" r="60" fill="#fff"/>
            <path
                    d="M99.484,84.357C97.7,77.573,87.53,74.266,84.016,73.2c-3.861-1.173-9.355-1.451-12.894-2.134-2.029-.384-4.974-1.344-5.964-2.368s-.4-10.518-.4-10.518a30.515,30.515,0,0,0,2.821-4.63c.99-2.155,2.079-8.086,2.079-8.086s2.029,0,2.747-3.072c.767-3.35,1.98-4.651,1.831-7.147-.148-2.454-1.708-2.39-1.708-2.39s1.51-3.563,1.683-10.945C74.438,13.141,66.469,4.5,52.041,4.5c-14.626,0-22.422,8.641-22.2,17.409.2,7.382,1.658,10.945,1.658,10.945s-1.559-.064-1.708,2.39c-.148,2.5,1.064,3.8,1.831,7.147.693,3.072,2.747,3.072,2.747,3.072s1.089,5.931,2.079,8.086a30.515,30.515,0,0,0,2.821,4.63s.594,9.494-.4,10.518-3.935,1.984-5.964,2.368c-3.539.683-9.033.96-12.894,2.134C16.5,74.266,6.33,77.573,4.548,84.357A1.792,1.792,0,0,0,6.5,86.427h91.05A1.786,1.786,0,0,0,99.484,84.357Z"
                    transform="translate(7.984 5.533)"/>
        </g>
	</svg>
    <p>Hi ${name}</p>
    <button onclick="changebox('infobar','formationbar')">Gérer les inscriptions</button>
    <button onclick="changebox('formationbar','infobar')">Your
        profile info
    </button>
    <form action="/logout" onsubmit="return myFunction()">
        <button formaction="/">revenir a accueil</button>
        <button type="submit">Déconnexion</button>

    </form>
</div>
<div id="formationbar">
    <h1>Les nouveaux etablissements en attent reponse</h1>
    <c:forEach var="Etablissement" items="${etablissementsattent}">
        <div id="boxformation">
            <img src="${Etablissement.getPhotosImagePath()}" alt="">
            <p> nom de Etablissement: ${Etablissement.getFullname()}</p>
            <form id="formformateur" action="/add/etablissement/false/${Etablissement.getId_etablissement()}">
                <button onclick="return myFunction()">refuse</button>
                <a href="#" onclick="return showmodel('etablissement${Etablissement.getId_etablissement()}')"
                   style="text-decoration: none;font-size: 1em;">More details</a>
                <button onclick="return myFunction()" formaction="/add/etablissement/true/${Etablissement.getId_etablissement()}">accepter</button>
            </form>
        </div>
        <div id="etablissement${Etablissement.getId_etablissement()}" class="modal">
            <div class="modal-content animate">
                <div class="container">
                    <p>information de Etablissement </p><br>
                    <p>nom: <b>${Etablissement.getFullname()}</b></p>
                    <p>email: <b>${Etablissement.getEmail()}</b></p>
                    <p>deplom: <b>${Etablissement.getNomDeplom()}</b></p>
                    <p>niveau : <b>${Etablissement.getNiveau()}</b></p>
                    <p> city : <b>${Etablissement.getCity()}</b></p>
                    <p> region :<b> ${Etablissement.getRegion()}</b></p>
                </div>
                <img alt="formation" src="${Etablissement.getPhotosImagePath()}" class="photo">
                <div class="container" style="background-color:#f1f1f1">
                    <button type="button"
                            onclick="document.getElementById('etablissement${Etablissement.getId_etablissement()}').style.display='none'"
                            class="cancelbtn">Cancel
                    </button>
                </div>
            </div>
        </div>
    </c:forEach>
    <h1>Les nouveaux apprenants en attent reponse</h1>
    <c:forEach var="Apprenant" items="${apprenantsattent}">
        <div id="boxformation">
            <img src="${Apprenant.getPhotosImagePath()}" alt="">
            <p> nom de Apprenant: ${Apprenant.getFullname()}</p>
            <form id="formformateur" action="/add/apprenant/false/${Apprenant.getId_apprenant()}">
                <button onclick="return myFunction()">refuse</button>
                <a href="#" onclick="return showmodel('apprenant${Apprenant.getId_apprenant()}')"
                   style="text-decoration: none;font-size: 1em;">More details</a>
                <button onclick="return myFunction()" formaction="/add/apprenant/true/${Apprenant.getId_apprenant()}">accepter</button>
            </form>
        </div>
        <div id="apprenant${Apprenant.getId_apprenant()}" class="modal">
            <div class="modal-content animate">
                <div class="container">
                    <p>information de Apprenant </p><br>
                    <p>nom: <b>${Apprenant.getFullname()}</b></p>
                    <p>email: <b>${Apprenant.getEmail()}</b></p>
                    <p>deplom: <b>${Apprenant.getNomDeplom()}</b></p>
                    <p>niveau : <b>${Apprenant.getNiveau()}</b></p>
                    <p> city : <b>${Apprenant.getCity()}</b></p>
                    <p> region :<b> ${Apprenant.getRegion()}</b></p>
                </div>
                <img alt="formation" src="${Apprenant.getPhotosImagePath()}" class="photo">
                <div class="container" style="background-color:#f1f1f1">
                    <button type="button"
                            onclick="document.getElementById('apprenant${Apprenant.getId_apprenant()}').style.display='none'"
                            class="cancelbtn">Cancel
                    </button>
                </div>
            </div>
        </div>
    </c:forEach>
    <h1>Les nouveaux formateur en attent reponse</h1>
    <c:forEach var="Formateur" items="${formateursattent}">
        <div id="boxformation">

            <img src="${Formateur.getPhotosImagePath()}" alt="">
            <p> nom de Formateur: ${Formateur.getFullname()}</p>
            <form id="formformateur" action="/add/formateur/true/${Formateur.getId_formateur()}">
                <button onclick="return myFunction()" formaction="/add/formateur/False/${formation.getId_formateur()}">refuse</button>
                <a href="#" onclick="return showmodel('formateur${Formateur.getId_formateur()}')"
                   style="text-decoration: none;font-size: 1em;">More details</a>
                <button onclick="return myFunction()">accept</button>
            </form>
        </div>
        <div id="formateur${Formateur.getId_formateur()}" class="modal">
            <div class="modal-content animate">
                <div class="container">
                    <p>information de Formateur </p><br>
                    <p>nom: <b>${Formateur.getFullname()}</b></p>
                    <p>email: <b>${Formateur.getEmail()}</b></p>
                    <p>deplom: <b>${Formateur.getNomDeplom()}</b></p>
                    <p>niveau : <b>${Formateur.getNiveau()}</b></p>
                    <p> city : <b>${Formateur.getCity()}</b></p>
                    <p> region :<b> ${Formateur.getRegion()}</b></p>
                </div>
                <img alt="formation" src="${Formateur.getPhotosImagePath()}" class="photo">
                <div class="container" style="background-color:#f1f1f1">
                    <button type="button"
                            onclick="document.getElementById('formateur${Formateur.getId_formateur()}').style.display='none'"
                            class="cancelbtn">Cancel
                    </button>
                </div>
            </div>
        </div>
    </c:forEach>
    <h1>Les formation en attenet reponse</h1>
    <c:forEach var="Formation" items="${formationsattent}">
        <div id="boxformation">

            <img src="${Formation.getPhotosImagePath()}" alt="">
            <p> nom de formation: ${Formation.getName_formation()}</p>
            <form id="formformation" action="/add/formation/true/${Formation.getId_formation()}">
                <button onclick="return myFunction()">accept</button>
                <a href="#" onclick="return showmodel('formation${Formation.getId_formation()}')"
                   style="text-decoration: none;font-size: 1em;">More details</a>
                <button onclick="return myFunction()" formaction="/add/formation/False/${Formation.getId_formation()}">refuse</button>
            </form>
        </div>
        <div id="formation${Formation.getId_formation()}" class="modal">
            <div class="modal-content animate">
                <div class="container">
                    <p>information de formation </p><br>
                    <p>nom: <b>${Formation.getName_formation()}</b></p>
                    <p>prix: <b>${Formation.getPrice()}</b></p>
                    <p>niveau : <b>${Formation.getNiveau()}</b></p>
                    <p> filier : <b>${Formation.getFilier()}</b></p>
                    <p> duree :<b> ${Formation.getDuree()}</b></p>
                </div>
                <img alt="formation" src="${Formation.getPhotosImagePath()}" class="photo">
                <div class="container" style="background-color:#f1f1f1">
                    <button type="button"
                            onclick="document.getElementById('formation${Formation.getId_formation()}').style.display='none'"
                            class="cancelbtn">Cancel
                    </button>
                </div>
            </div>
        </div>
    </c:forEach>
    <h1>Etablissement deja accepter</h1>
    <c:forEach var="Etablissement" items="${etablissementsaccepter}">
        <div id="boxformation">
            <img src="${Etablissement.getPhotosImagePath()}" alt="">
            <p> nom de Etablissement: ${Etablissement.getFullname()}</p>
            <form id="formformateur" action="/add/etablissement/false/${Etablissement.getId_etablissement()}">
                <a href="#" onclick="return showmodel('etab${Etablissement.getId_etablissement()}')"
                   style="text-decoration: none;font-size: 1em;">More details</a>
                <button onclick="return myFunction()">Supprimer</button>
            </form>
        </div>
        <div id="etab${Etablissement.getId_etablissement()}" class="modal">
            <div class="modal-content animate">
                <div class="container">
                    <p>information de Etablissement </p><br>
                    <p>nom: <b>${Etablissement.getFullname()}</b></p>
                    <p>email: <b>${Etablissement.getEmail()}</b></p>
                    <p>deplom: <b>${Etablissement.getNomDeplom()}</b></p>
                    <p>niveau : <b>${Etablissement.getNiveau()}</b></p>
                    <p> city : <b>${Etablissement.getCity()}</b></p>
                    <p> region :<b> ${Etablissement.getRegion()}</b></p>
                </div>
                <img alt="formation" src="${Etablissement.getPhotosImagePath()}" class="photo">
                <div class="container" style="background-color:#f1f1f1">
                    <button type="button"
                            onclick="document.getElementById('etab${Etablissement.getId_etablissement()}').style.display='none'"
                            class="cancelbtn">Cancel
                    </button>
                </div>
            </div>
        </div>
    </c:forEach>
    <h1>Apprenant deja accepter</h1>
    <c:forEach var="Apprenant" items="${apprenantsaccepter}">
        <div id="boxformation">
            <img src="${Apprenant.getPhotosImagePath()}" alt="">
            <p> nom de Apprenant: ${Apprenant.getFullname()}</p>
            <form id="formformateur" action="/add/apprenant/false/${Apprenant.getId_apprenant()}">
                <a href="#" onclick="return showmodel('app${Apprenant.getId_apprenant()}')"
                   style="text-decoration: none;font-size: 1em;">More details</a>
                <button onclick="return myFunction()">supprimer</button>
            </form>
        </div>
        <div id="app${Apprenant.getId_apprenant()}" class="modal">
            <div class="modal-content animate">
                <div class="container">
                    <p>information de Apprenant </p><br>
                    <p>nom: <b>${Apprenant.getFullname()}</b></p>
                    <p>email: <b>${Apprenant.getEmail()}</b></p>
                    <p>prix: <b>${Apprenant.getNomDeplom()}</b></p>
                    <p>niveau : <b>${Apprenant.getNiveau()}</b></p>
                    <p> filier : <b>${Apprenant.getCity()}</b></p>
                    <p> duree :<b> ${Apprenant.getRegion()}</b></p>
                </div>
                <img alt="formation" src="${Apprenant.getPhotosImagePath()}" class="photo">
                <div class="container" style="background-color:#f1f1f1">
                    <button type="button"
                            onclick="document.getElementById('app${Apprenant.getId_apprenant()}').style.display='none'"
                            class="cancelbtn">Cancel
                    </button>
                </div>
            </div>
        </div>
    </c:forEach>
    <h1>Formateur deja accepter</h1>
    <c:forEach var="Formateur" items="${formateursaccepter}">
        <div id="boxformation">
            <img src="${Formateur.getPhotosImagePath()}" alt="">
            <p> nom de Formateur: ${Formateur.getFullname()}</p>
            <form id="formformateur" action="/add/formateur/false/${Formateur.getId_formateur()}">
                <a href="#" onclick="return showmodel('Formateur${Formateur.getId_formateur()}')"
                   style="text-decoration: none;font-size: 1em;">More details</a>
                <button onclick="return myFunction()">supprimer</button>
            </form>
        </div>
        <div id="Formateur${Formateur.getId_formateur()}" class="modal">
            <div class="modal-content animate">
                <div class="container">
                    <p>information de Formateur </p><br>
                    <p>nom: <b>${Formateur.getFullname()}</b></p>
                    <p>email: <b>${Formateur.getEmail()}</b></p>
                    <p>prix: <b>${Formateur.getNomDeplom()}</b></p>
                    <p>niveau : <b>${Formateur.getNiveau()}</b></p>
                    <p> filier : <b>${Formateur.getCity()}</b></p>
                    <p> duree :<b> ${Formateur.getRegion()}</b></p>
                </div>
                <img alt="formation" src="${Formateur.getPhotosImagePath()}" class="photo">
                <div class="container" style="background-color:#f1f1f1">
                    <button type="button"
                            onclick="document.getElementById('Formateur${Formateur.getId_formateur()}').style.display='none'"
                            class="cancelbtn">Cancel
                    </button>
                </div>
            </div>
        </div>
    </c:forEach>
    <h1> formation deja accepter</h1>
    <c:forEach var="Formation" items="${formationsaccepter}">
        <div id="boxformation">

            <img src="${Formation.getPhotosImagePath()}" alt="">
            <p> nom de Formation: ${Formation.getName_formation()}</p>
            <form id="formformation" action="/add/formation/false/${Formation.getId_formation()}">
                <a href="#" onclick="return showmodel('Formation${Formation.getId_formation()}')"
                   style="text-decoration: none;font-size: 1em;">More details</a>
                <button onclick="return myFunction()">Supprimer</button>
            </form>
        </div>
        <div id="Formation${Formation.getId_formation()}" class="modal">
            <div class="modal-content animate">
                <div class="container">
                    <p>information de formation </p><br>
                    <p>nom: <b>${Formation.getName_formation()}</b></p>
                    <p>prix: <b>${Formation.getPrice()}</b></p>
                    <p>niveau : <b>${Formation.getNiveau()}</b></p>
                    <p> filier : <b>${Formation.getFilier()}</b></p>
                    <p> duree :<b> ${Formation.getDuree()}</b></p>
                </div>
                <img alt="formation" src="${Formation.getPhotosImagePath()}" class="photo">
                <div class="container" style="background-color:#f1f1f1">
                    <button type="button"
                            onclick="document.getElementById('Formation${Formation.getId_formation()}').style.display='none'"
                            class="cancelbtn">Cancel
                    </button>
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
                <a  href="/deleteinscriptionadmin/${Inscriptions.getId_insc()}" onclick="return myFunction()" style="text-decoration: none;font-size: 1em;grid-area: btn1">Suprimer</a>
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
                    <p>information d'etablissement </p>
                    <p>nom: <b>${Inscriptions.getEtab().getFullname()}</b> email:
                        <b>${Inscriptions.getEtab().getEmail()}</b></p>
                    <p> city: <b>${Inscriptions.getEtab().getCity()}</b></p>
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
<div id="infobar" style="padding-top: 5%">
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
<script>
    function showmodel(id) {
        document.getElementById(id).style.display = 'block';
        return false;
    }

    function Validate() {
        var password = document.getElementById('password1');
        var confirmPassword = document.getElementById('password2');
        var form = document.getElementById('changeform');
        if (password.value != confirmPassword.value) {
            confirmPassword.style.borderColor = 'red';
            alert("Passwords do not match.");
            return false;
        } else {
            var a = document.getElementById('password1');
            var b = document.getElementById('fullname');
            var c = document.getElementById('email');
            a.disabled = false;
            b.disabled = false;
            c.disabled = false;
            form.action = "/changeAdminInfo";
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
        return false;
    }

    function changebox(id1, id2) {
        var x = document.getElementById(id1);
        x.style.display = 'none';
        var x = document.getElementById(id2);
        if (id2 == 'infobar') {
            x.style.display = 'block';
        } else {
            x.style.display = 'grid';
        }
    }
    function myFunction() {

        var r = confirm("êtes-vous sûr? ");
        return r;
    }
</script>
</body>

</html>