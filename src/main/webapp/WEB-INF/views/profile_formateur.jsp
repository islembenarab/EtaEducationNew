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
                $.post("/verifierpassform", {
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
        $(document).ready(function () {
            $("#propose").click(function () {
                $("#formationbar").css("display", "none");
                $("#infobar").css("display", "none");
                $("#proposeFormation").css("display", "block");
            });
        });
        $(document).ready(function () {
            $("#condidature").click(function () {
                $("#formationbar").css("display", "grid");
                $("#infobar").css("display", "none");
                $("#proposeFormation").css("display", "none");
            });
        });
        $(document).ready(function () {
            $("#info").click(function () {
                $("#formationbar").css("display", "none");
                $("#infobar").css("display", "block");
                $("#proposeFormation").css("display", "none");
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

    <p>Bonjour ${name}</p>
    <button id="condidature">votre condidature</button>
    <button id="propose">proposer une formation</button>
    <button id="info">votre information</button>
    <form action="/">
        <button>revenir a accueil</button>
        <button formaction="/consultoff">consult plus offres</button>
        <button formaction="/logout">déconnexion</button>
    </form>
</div>
<div id="formationbar">
    <p> ${message1} </p>
    <c:forEach var="Condidature" items="${condidaturesattent}">
        <div id="boxformation">

            <img src="${Condidature.getForm().getPhotosImagePath()}" alt="">
            <p style="grid-area: info1"> nom de formation: ${Condidature.getForm().getName_formation()} </p>
            <p style="grid-area: info2"> nom de etablissement :${Condidature.getEtab().getFullname()}</p>
            <form id="formformation" action="/reponsecondidature/true/${Condidature.getId_condidature()}">
                <button>accept</button>
                <a href="#" onclick="return showmodel('${Condidature.getId_condidature()}')"
                   style="text-decoration: none;font-size: 1em;">More details</a>
                <button formaction="/reponsecondidature/False/${Condidature.getId_condidature()}">refuse</button>
            </form>
        </div>
        <div id="${Condidature.getId_condidature()}" class="modal">
            <div class="modal-content animate">
                <div class="container">
                    <p>information de etablissement </p>
                    <p>nom: <b>${Condidature.getEtab().getFullname()}</b></p>
                    <p>nom: <b>${Condidature.getEtab().getCity()}</b></p>
                    <p>nom: <b>${Condidature.getEtab().getEmail()}</b></p>
                    <p>information de formation </p>
                    <p>nom: <b>${Condidature.getForm().getName_formation()}</b></p>
                    <p>prix: <b>${Condidature.getForm().getPrice()}</b></p>
                    <p>niveau : <b>${Condidature.getForm().getNiveau()}</b></p>
                    <p> filier : <b>${condidature.getForm().getFilier()}</b></p>
                    <p> duree :<b> ${Condidature.getForm().getDuree()}</b></p>
                </div>
                <img alt="formation" src="${Condidature.getForm().getPhotosImagePath()}" class="photo">
                <div class="container" style="background-color:#f1f1f1">
                    <button type="button"
                            onclick="document.getElementById('${Condidature.getId_condidature()}').style.display='none'"
                            class="cancelbtn">Cancel
                    </button>
                </div>
            </div>
        </div>
    </c:forEach>
    <h1>les condidatures deja accepter</h1>
    <c:forEach var="Condidature" items="${condidaturesaccepter}">

        <div id="boxformation">

            <img src="${Condidature.getForm().getPhotosImagePath()}" alt="">
            <p style="grid-area: info1"> nom de formation: ${Condidature.getForm().getName_formation()}</p>
            <p style="grid-area: info2"> nom de etablissement :${Condidature.getEtab().getFullname()}</p>
            <form id="formformation" action="/reponsecondidature/false/${Condidature.getId_condidature()}">
                <a href="#" onclick="return showmodel('conde${Condidature.getId_condidature()}')"
                   style="text-decoration: none;font-size: 1em;">Plus details</a>
                <button>Supprimer</button>
            </form>
        </div>
        <div id="conde${Condidature.getId_condidature()}" class="modal">
            <div class="modal-content animate">
                <div class="container">
                    <p>information de etablissement </p>
                    <p>nom: <b>${Condidature.getEtab().getFullname()}</b></p>
                    <p>city: <b>${Condidature.getEtab().getCity()}</b></p>
                    <p>email: <b>${Condidature.getEtab().getEmail()}</b></p>
                    <p>information de formation </p>
                    <p>nom: <b>${Condidature.getForm().getName_formation()}</b></p>
                    <p>prix: <b>${Condidature.getForm().getPrice()}</b></p>
                    <p>niveau : <b>${Condidature.getForm().getNiveau()}</b></p>
                    <p> filier : <b>${Condidature.getForm().getFilier()}</b></p>
                    <p> duree :<b> ${Condidature.getForm().getDuree()}</b></p>
                </div>
                <img alt="formation" src="${Condidature.getForm().getPhotosImagePath()}" class="photo">
                <div class="container" style="background-color:#f1f1f1">
                    <button type="button"
                            onclick="document.getElementById('conde${Condidature.getId_condidature()}').style.display='none'"
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
<div id="proposeFormation" style="padding-top: 5%">
    <form action="/proposeF" method="post" enctype="multipart/form-data">
        <br>
        <input type="text" name="name_formation" placeholder="nom de formation" required>
        <br>
        <input type="text" name="filier" placeholder="filier de formation" required>
        <br>
        <input type="text" name="duree" placeholder="duree de formation" required>
        <br>
        <select name="niveau" id="" required>
            <option value="">niveau du education</option>
            <option value="1">1 anne primier</option>
            <option value="2">2 anne primier</option>
            <option value="3">3 anne primier</option>
            <option value="4">4 anne primier</option>
            <option value="5">5 anne primier</option>
            <option value="6">1 anne moyenne</option>
            <option value="7">2 anne moyenne</option>
            <option value="8">3 anne moyenne</option>
            <option value="9">4 anne moyenne</option>
            <option value="10">1 anne secondaire</option>
            <option value="11">2 anne secondaire</option>
            <option value="12">3 anne secondaire</option>
            <option value="13">admit en bac</option>
            <option value="14">1 anne unversaire</option>
            <option value="15">2 anne unversaire</option>
            <option value="16">3 anne unversaire</option>
            <option value="17">1 anne unversaire Master</option>
            <option value="18">2 anne unversaire Master</option>
        </select>
        <br>
        <input type="number" name="price" placeholder="prix de formation">
        <br>
        <input type="file" name="file" placeholder="image cover de formation">
        <br>
        <button style="margin: 10% 25% 10% 25%">propser</button>
    </form>
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
            form.action = "/changeinfoform";
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

</script>
</body>

</html>