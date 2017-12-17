<html lang="en">
<head>
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" href="quiz.css">
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
			     <p style="color:white"><em>Come And Learn Java In The Best Way</em><p>
							
								<form style="width:300px" action="login.jsp">  
									<div class="form-group">   
										<input type="email" class="form-control glyphicon" id="InputEmail1" name="InputEmail1" placeholder="&#x2709 Email" required />  
									</div>  
									<div class="form-group">  
										<input type="password" class="form-control glyphicon" id="InputPassword1" name="InputPassword1" placeholder="&#57395 Password" required />  
									</div> 
									<div class="checkbox">
										<label style="float:left"><input type="checkbox" value=""><font color="white">Remember me</font></label><label style="float:right"><a href="forgetpass.jsp"><font color="red">forget password?</font></a></label>
									</div>
									<br/>
									<br/>
									<button type="submit" class="btn btn-success btn-block">Login</button>
									<br/>
									<a href="index.jsp"class="btn btn-block btn-primary">click here to sign up</a>
									<hr/>
									<hr/>
								</form> 
			</center>		 
		 </div>
     </div>
</div>
</body>
</html>