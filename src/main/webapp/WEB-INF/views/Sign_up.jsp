<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign up</title>
    <link rel="stylesheet" href="/css/sign.css?version=51">
</head>

<body>
<header>
 <span id="logo"><a  href="/"><img id="logo" alt="" src="/img/logo.png"></a></span>
</header>
    <div id="boxsign_up">
        <form action="/adduser" method="post" id="formsign_up" enctype="multipart/form-data" onsubmit="return Validate()">
            <input type="text" placeholder="complete nom" name="fullname" id=""required>
            <input type="text" placeholder="Email" name="email" id=""required>
            <select name="niveau" id=""  required>
            <option value="" >niveau d'education</option>
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
            <input type="password" placeholder="mot de pass" name="password" id="password1" required>
            <input type="password" placeholder="confirmer mot de pass" name="" id="password2" required>
            <select name="type" id="type" oninput="change()" required>
            <option value="" >type</option>
            <option value="apprenant" >Aprenant</option>
            <option value="etablishment">etablishment</option>
            <option value="formateur">Formateur</option>
            </select>
            <input type="text" value="" placeholder="le nom de deplom"  name="nomDeplom"  >
            <input type="file" value="" placeholder="deplom"  name="file"  >
             <select name="region"required>
            <option value="">region</option>  
            <option value="Sud">Sud</option>
            <option value="Nord">Nord</option>
            <option value="Est">Est</option>
            <option value="Ouest">Ouest</option>
            </select>
            <select name="city"required>
            <option value="">ville</option>
            <option value="ghardaia">ghardaia</option>
            <option value="constantine">constantine</option>
            <option value="khenchla">khenchla</option>
            </select>
            <button type="submit" style="margin-bottom: 1%;">inscrit</button>
            <p style="margin-bottom: 2px;">Vous avez déjà un compte? </p>
            <a id="a"href="/sign_in" style="text-decoration: none;margin:0 auto 2% auto;"><b>Se connect</b></a>
        </form>
    </div>
    <pre id="psign_up">
        Be the person who you want
         not what <b>THEY</b> want
    </pre>
    <script>
    function Validate() {
		var password = document.getElementById('password1');
		var confirmPassword = document.getElementById('password2');
		var form = document.getElementById('formsign_up');
		if (password.value !== confirmPassword.value) {
			confirmPassword.style.borderColor = 'red';
			alert("Passwords do not match.");
			return false;
		}else{
			return true;
		}}
    </script>
</body>
    

</html>