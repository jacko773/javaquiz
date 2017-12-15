<html lang="en">
<head>
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	<link rel="stylesheet" href="quiz.css">
	 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
  #home{
	  margin-top:80px;
  }
  
  </style>
</head>
<body background="">
			<jsp:include page="header.jsp"/>
			<div id="home" class="tab-pane fade in active">
	 <div class="">
		 <div class="container"> 
             <center>	 
			     <p><em>Come And Learn Java In The Best Way</em><p>
<form action="SignUp.jsp" method="GET" name="myform" style="width:300px" onsubmit="return validateform()">  
  <div class="form-group">    
    <input type="text" class="form-control glyphicon" id="user" name="user" placeholder="&#57352 User name" required/>
  </div> 		 
  <div class="form-group">    
    <input type="email" class="form-control glyphicon" id="InputEmail2" name="InputEmail2" placeholder="&#x2709 Email"/>  
  </div>  
  <div class="form-group">    
    <input type="password"  class="form-control glyphicon" id="InputPassword2" name="Userpass" onkeyup="validate()" placeholder="&#57395 Password"/> 
	<div style="color:red">password strength:<span id="confirm">no strength</span></div> 
  </div>
  <div class="form-group">   
    <input type="password" class="form-control glyphicon" id="InputPassword3" name="InputPassword3"  placeholder="&#57395 Confirm_Password"/>  
  </div> 
<br/>  
  <button type="submit" class="btn btn-success btn-block">SignUp & Learn Java</button>  
  <br/>
  <button class="btn btn-block btn-primary" data-toggle="modal" data-target="#mymodel" aria-hidden = "true">click here to sign in</button>
</form>
 </center>	
	<div class="modal fade" id="mymodel">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<p><font size="5px">sign in</font></p>
				</div>
				<div class="modal-body">
					
								<center>
								<form style="width:300px" action="login.jsp">  
									<div class="form-group">   
										<input type="email" class="form-control glyphicon" id="InputEmail1" name="InputEmail1" placeholder="&#x2709 Email" required />  
									</div>  
									<div class="form-group">  
										<input type="password" class="form-control glyphicon" id="InputPassword1" name="InputPassword1" placeholder="&#57395 Password" required />  
									</div>  
									<br/>
									<button type="submit" class="btn btn-success btn-block">Login</button>  
								</form> 
								</center>
													
				</div>
				<div class="modal-footer">
					<button class="btn" data-dismiss="modal">&times</button>
				</div>
			</div>
		</div>
	</div>
            		 
		 </div>
     </div>
</div>
 	<script type="text/javascript">
			function validateform(){
				var email=document.getElementById("InputEmail2").value;
				var password=document.getElementById("InputPassword2").value;
				var confirmpassword=document.getElementById("InputPassword3").value;
				var regex=/^[a-zA-Z0-9][a-zA-Z0-9-\.]*@(gmail)[.](com|travel)$/;
				var regex1=/^(?=.*\d)(?=.*[!@#$%^&*])(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9!@#$%^&]{6,10}$/
				if(regex.test(email)){
				}else{
					alert("invalid email address");
					return false;
				}
				if(password!=confirmpassword){
					alert("password should match");
					return false;
				}
				if(regex1.test(password)){
					alert("valid email adress and password");
					return true;
				}else{
					alert("invalid password");
					return false;
				}
			}
			
		</script>
		<script type="text/javascript" >  
			function validate() { 
				var password1=document.getElementById("InputPassword2").value;
				var msg; 
				if(password1.length>5){
					msg="good";
				}else{
					msg="bad";
				}
				document.getElementById("confirm").innerText=msg;
			}    
		</script>
</body>
</html>