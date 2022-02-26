<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign in</title>
    <link rel="stylesheet" href="/css/sign.css?version=51">
</head>

<body>
<header>
 <span ><a  href="/"><img  alt="" src="/img/logo.png"></a></span>
</header>
    <div id="boxsing">
        <form action="/authentify" method="post" style="margin-top: 8%;">
            <h3 style="color: red">${messagelogin}</h3>
            <input type="text" placeholder="Email" name="email"  style="height: 40px;margin-top: 0;" required>
            <input type="password" placeholder="mot de pass" name="password" style="height: 40px" required>
            <select name="type" id="type" style="height: 40px" required>
            	<option value="">Type</option>
                <option value="admin">Admin</option>
                <option value="apprenant">Aprenant</option>
                <option value="etablissement">etablissement</option>
                <option value="formateur">formateur</option>
            </select>
            <label class="container">souviens-toi de moi
                <input type="checkbox"  value="true" name="remember" id="remember" >
                <span class="checkmark"></span>
              </label>
            <button type="submit" >Se Connect</button>
            <p>Vous n'avez pas de compte auparavant ?</p>
            <a id="a" href="/Sign_up" style="text-decoration: none;">inscrire</a>
        </form>
    </div>
    <pre class="singINPRE">make your own way by
        <b>yourself</b>
    </pre>
<script type="text/javascript">
	
</script>
</body>

</html>