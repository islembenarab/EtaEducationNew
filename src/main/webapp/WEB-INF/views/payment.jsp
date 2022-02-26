<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body {
            font-family: Arial;
            font-size: 17px;
            padding: 8px;
        }
        
        * {
            box-sizing: border-box;
        }
        
        .row {
            display: -ms-flexbox;
            /* IE10 */
            display: flex;
            -ms-flex-wrap: wrap;
            /* IE10 */
            flex-wrap: wrap;
            margin: 0 -16px;
        }
        
        .col-25 {
            -ms-flex: 25%;
            /* IE10 */
            flex: 25%;
        }
        
        .col-50 {
            -ms-flex: 50%;
            /* IE10 */
            flex: 50%;
        }
        
        .col-75 {
            -ms-flex: 75%;
            /* IE10 */
            flex: 75%;
        }
        
        .col-25,
        .col-50,
        .col-75 {
            padding: 0 16px;
        }
        
        .container {
            background-color: #f2f2f2;
            padding: 5px 20px 15px 20px;
            border: none;
            border-radius: 10px;
            box-shadow: 5px 5px 25px grey, -5px -5px 25px grey;
        }
        
        input[type=text],
        select {
            width: 100%;
            margin-bottom: 20px;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        
        label {
            margin-bottom: 10px;
            display: block;
        }
        
        .icon-container {
            margin-bottom: 20px;
            padding: 7px 0;
            font-size: 24px;
        }
        
        .btn {
            background: linear-gradient(darkblue, rgb(72, 96, 175));
            color: white;
            padding: 12px;
            margin: 10px 0;
            border: none;
            width: 100%;
            border-radius: 3px;
            cursor: pointer;
            font-size: 17px;
        }
        
        .btn:hover {
            background: linear-gradient(white, gray);
            transition: 0.5s;
            color: black;
        }
        
        a {
            color: #2196F3;
        }
        
        hr {
            border: 1px solid lightgrey;
        }
        
        span.price {
            float: right;
            color: grey;
        }
        /* Responsive layout - when the screen is less than 800px wide, make the two columns stack on top of each other instead of next to each other (also change the direction - make the "cart" column go on top) */
        
        @media (max-width: 800px) {
            .row {
                flex-direction: column-reverse;
            }
            .col-25 {
                margin-bottom: 20px;
            }
        }
    </style>
</head>

<body>
    <div class="row">
        <div class="col-75">
            <div class="container">
                <form method="post" action="/pay/${id_condidature}">
                    <div class="col-50">
                        <h3>Payment</h3>
                        <label>Accepted Cards</label>
                        <div class="icon-container">
                            <i class="fa fa-cc-visa" style="color:navy;"></i>
                            <i class="fa fa-cc-amex" style="color:blue;"></i>
                            <i class="fa fa-cc-mastercard" style="color:red;"></i>
                            <i class="fa fa-cc-discover" style="color:orange;"></i>
                        </div>
                        <label for="price">price</label>
                        <input type="text" id="price" name="price" value="${price}" disabled>
 						<label for="currency">currency</label>
                        <select name="currency" id="" required="required">
                            <option value="">currency</option>
                            <option value="EUR">EUR</option>
                        </select>
                        <label for="method">Payment Method</label>
                        <select name="method" id="" required="required">
                            <option value="">Payment Method</option>
                            <option value="Paypal">Paypal</option>
                        </select>
						<label for="intent">Intent</label>
                    	<input type="text" id="intent" name="intent" value="sale" required>
                        <label for="description">Payment Description</label>
                        <input type="text" id="description" name="description" placeholder="Payment Description">

                    </div>

                    <input type="submit" value="Continue to checkout" class="btn" onclick="getinfo()">
                </form>
            </div>
        </div>

    </div>
<script type="text/javascript">
	function getinfo(){
		var x = document.getElementById('price');
		x.disabled=false
	}
</script>
</body>

</html>