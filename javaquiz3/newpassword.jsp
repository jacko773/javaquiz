<%
String tocken=request.getParameter("tocken");
%>
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
							<p style="color:white"><em>Enter your new password</em></p>
								<form style="width:300px" action="changepassword.jsp">  
									<div class="form-group">   
										<input type="password" class="form-control glyphicon" id="password" name="password" placeholder="&#x2709 password" required />  
									</div>  
									<div class="form-group">   
										<input type="password" class="form-control glyphicon" id="confirm_password" name="confirm_password" placeholder="&#x2709 confirm_password" required />  
									</div> 
									<input type="hidden" name="tocken" value="<%=tocken%>"></input>
									<button type="submit" class="btn btn-success btn-block send">Change Password</button>
									<hr/>
									<hr/>
								</form> 
			</center>		 
		 </div>
     </div>
</div>
</body>
</html>