<!DOCTYPE html>  
<html lang="eng">
<head>
     <meta name="viewport" content="width=device-width, initial-scale=1">  
     <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	 <link rel="stylesheet" href="quiz.css">	 	
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="fluid-container" style="margin:0px">   
         <ul class="nav nav-tabs navbar-inverse" >
             <li class="active"><a data-toggle="tab" href="#home">Home</a></li>
             <li><a data-toggle="tab" href="#SignIn">SignIn</a></li>
			 <li><a data-toggle="tab" href="#Quiz">Java Quizes</a></li>
			 <li><a data-toggle="tab" href="#dsquiz">DS Quizes</a></li>
			 <li><a data-toggle="tab" href="#CoreJava">Core Java</a></li>
			 <li><a data-toggle="tab" href="#AdvJava">Adv Java</a></li>
			 <li><a data-toggle="tab" href="#DS">Data Structure</a></li>
			 <li><a data-toggle="tab" href="#Interview">Interview</a></li>
             <li><a data-toggle="tab" href="#Contact">Contact</a></li>			 
         </ul>    
</div>


<div class="tab-content">
<div id="home" class="tab-pane fade in active">
	 <div class="jumbotron" style="background-color:#566573">
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
	<div style="color:green">Strength:<span id="confirm">no strength</span></div> 
  </div>
  <div class="form-group">   
    <input type="password" class="form-control glyphicon" id="InputPassword3" name="InputPassword3"  placeholder="&#57395 Confirm_Password"/>  
  </div>  
    <br/>
  <button type="submit" class="btn btn-success btn-block">SignUp & Learn Java</button>  
</form>
             </center>			 
		 </div>
     </div>
</div>



<div id="SignIn" class="tab-pane fade">
<div class="jumbotron" style="background-color:#566573">
<div class="container">
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
</div>
</div>



<div id="Quiz" class="tab-pane fade">
   <div class="container">
     <div class="row">
	     <div class= "col-md-6 col-xs-12 col-sm-12" >
		    <center>
			<b>Core java</b><br/><br/>
			 <div class="col-md-12" id="testt">			     			         
			 <a href='quiz30.jsp?test=<%="cj30"%>'>30 minutes test</param></a><br/>				  
			 </div>
			 <div class="col-md-12" id="testt">
			 <a href="quiz30.jsp?test=<%="cj60"%>">60 minutes test</a><br/>
			 </div>
			 <div class="col-md-12" id="testt">
			 <a href='quiz30.jsp?test=<%="cj120"%>'>120 minute test</a><br/>
			 </div>
             </center>			 
		 </div>
		     <div class="clearfix visible-xs visible-sm"></div>
		 <div class="col-md-6 col-xs-12 col-sm-12">
		     <center>
		     <b>Advance java</b><br/><br/>
			 <div class="col-md-12" id="testt">
			 <a href='quiz30.jsp?test=<%="aj30"%>'>30 minutes test</a><br/>
			 </div>
			 <div class="col-md-12" id="testt">
			 <a href='quiz30.jsp?test=<%="aj60"%>'>60 minutes test</a><br/>
			 </div>
			 <div class="col-md-12" id="testt">
			 <a href='quiz30.jsp?test=<%="aj120"%>'>120 minute test</a><br/>
			 </div>
			 <center>
		 </div>
     </div>	 
   </div> 
</div>

<div id="CoreJava" class="tab-pane fade">
<em>Basics:<em>



</div>

<div id="AdvJava" class="tab-pane fade">

</div>

<div id="Interview" class="tab-pane fade">

</div>

<div id="Contact" class="tab-pane fade">

</div>

</div>

</body>
</html>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>  
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
