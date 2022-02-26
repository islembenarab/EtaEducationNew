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
                $.post("/verifierpass", {
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

        function showmodel(id) {
            document.getElementById(id).style.display = 'block';
            return false;
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

    <p>Bonjour ${name}</p>
    <button onclick="changebox('infobar','formationbar')">votre
        formations
    </button>
    <button onclick="changebox('formationbar','infobar')">votre
        profile information
    </button>
    <form action="/logout" onsubmit="return myFunction()">
        <button formaction="/">revenir a accueil</button>
        <button formaction="/consultform/all/all/all">consulter plus de formation</button>
        <button type="submit">déconnexion</button>
    </form>
</div>
<div id="formationbar">
    <c:forEach var="Inscriptions" items="${formations}">

        <div id="boxformation">

                <img src="${Inscriptions.getFormation().getPhotosImagePath()}" alt="">
                <p style="grid-area: info1"> name: ${Inscriptions.getFormation().getName_formation()}</p>
                <p style="grid-area: info2"> niveau : ${Inscriptions.getFormation().getNiveau()}</p>
                <p style="grid-area: info3"> filier : ${Inscriptions.getFormation().getFilier()}</p>
                <div style="grid-area: btn">
                <a  href="/deleteinscription/${Inscriptions.getId_insc()}" onclick="return myFunction()" style="text-decoration: none;font-size: 1em;grid-area: btn1">Suprimer</a>
                <a href="#" onclick="return showmodel('${Inscriptions.getId_insc()}')"
                   style="text-decoration: none;font-size: 1em;grid-area: btn2">More details</a>
                </div>
        </div>
        <div id="${Inscriptions.getId_insc()}" class="modal">
            <div class="modal-content animate">
                <div class="container">
                    <h1>information de Formateur </h1>
                    <p>nom: <b>${Inscriptions.getForma().getFullname()}</b></p>
                    <p>Email: <b>${Inscriptions.getForma().getEmail()}</b></p>
                    <p>ville: <b>${Inscriptions.getForma().getCity()}</b></p>
                    <p>Region: <b>${Inscriptions.getForma().getRegion()}</b></p>
                    <p>deplom: <b>${Inscriptions.getForma().getNomDeplom()}</b></p>
                    <h1>information d'etablissement</h1>
                    <p>nom: <b>${Inscriptions.getEtab().getFullname()}</b></p>
                    <p>Email: <b>${Inscriptions.getEtab().getEmail()}</b></p>
                    <p>Ville: <b>${Inscriptions.getEtab().getCity()}</b></p>
                    <p>Region: <b>${Inscriptions.getEtab().getRegion()}</b></p>
                </div>
                <div class="container">
                    <h1>information de formation </h1>
                    <p>nom: <b>${Inscriptions.getFormation().getName_formation()}</b></p>
                    <p>prix: <b>${Inscriptions.getFormation().getPrice()}</b></p>
                    <p>niveau : <b>${Inscriptions.getFormation().getNiveau()}</b></p>
                    <p> filier : <b>${Inscriptions.getFormation().getFilier()}</b></p>
                    <p> duree :<b> ${Inscriptions.getFormation().getDuree()}</b></p>
                </div>
                <img alt="formation" src="${Inscriptions.getFormation().getPhotosImagePath()}" class="photo">
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
        <form id="changeform" method="POST" onSubmit="return Validate();">
            <label for="fullname"> full name</label>
            <br>
            <input type="text" value="${name}" id="fullname" name="fullname" disabled><br>
            <a href="#" onclick="return changeinfo('fullname')">change</a>
            <br>
            <label for="email">email</label> <br>
            <input type="text" value="${email}" id="email" name="email" disabled><br>
            <a href="#" onclick="return changeinfo('email')">change</a> <br>
            <label for="password1">password</label> <br>
            <input type="password" value="${mdp}" id="password1" name="password" disabled><br>
            <a href="#" onclick="return changeinfo('password1')">change</a> <br>
            <label for="password2">confirm Password</label> <br>
            <input type="password" value="${mdp}" id="password2" disabled> <br>
            <select name="city" id="city" disabled>
                <option value="${ville}">${ville}</option>
                <option value="ghardaia">ghardaia</option>
                <option value="constantine">constantine</option>
                <option value="khenchla">khenchla</option>
            </select><br> <a href="#" onclick="return changeinfo('city')">change</a> <br>
            <button type="submit" style="margin: 0 25% 0 25%">Verifier</button>
        </form>
    </div>
</div>
<script>
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
            var d = document.getElementById('city');
            a.disabled = false;
            b.disabled = false;
            c.disabled = false;
            d.disabled = false;
            form.action = "/changeinfo";
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
            x.style.display = 'flex';
        }
    }

    function myFunction() {

        var r = confirm("êtes-vous sûr? ");
        return r;
    }
</script>
</body>

</html>