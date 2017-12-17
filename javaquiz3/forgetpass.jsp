<html lang="en">
<head>
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
    body{
	  background-image:url("edu2.jpg");
	  background-repeat: no-repeat;
    background-size: 100% 100%;
	background-color:grey;
	opacity:0.7;
  }
  #home{
	  margin-top:120px;
  } 
  </style>
</head>
<body>
<jsp:include page="header.jsp"/>
<div id="home" class="">
	 <div class="">
		 <div class="container"> 
             <center>	 
			     <p style="color:white"><em>Enter your email below to send password<br/>reset link and instruction</em></p>
							
								<form style="width:300px" action="sendemail.jsp">  
									<div class="form-group">   
										<input type="email" class="form-control glyphicon" id="InputEmail1" name="to" placeholder="&#x2709 Enter Your Registered Email" required />  
									</div>  
								
									<button type="submit" class="btn btn-success btn-block send">Send Password Reset Link</button>
									<br/>
									<a href="signin.jsp"class="btn btn-block btn-primary">click here to sign in</a>
									<hr/>
									<hr/>
								</form> 
			</center>		 
		 </div>
     </div>
</div>
<script>
	$(document).ready(function(){
		$(".send").click(function(){
			$(".send").text("verifying data");
		});
	});
</script>
</body>
</html>