<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/homecss.css?version=51">
    <title>EtaEducation</title>
</head>

<body>
    <header >
        <a  href="/" style="margin-right: 20%"><img id="logo" alt="" src="/img/logo.png" ></a>
        <a href="">About Us</a>
        <a href="/">Home</a>
        <a href="${url_signin}">${button_signin}</a>
        <a href="${url_signup}">${button_signup}</a>
    </header>
    <p>${message}"</p>
    <img id="imghome"src="/img/img_home.gif" alt="">
    <pre class="homePRE">EtaEducation your way to
     successful life</pre>
    <div class="homeBTN">
        <a href="${url_button_consult}">${button_consult}</a>
        <a href="${url_signup2}">${button_signup2}</a>
    </div>

    <script >
    </script>

</body>

</html>