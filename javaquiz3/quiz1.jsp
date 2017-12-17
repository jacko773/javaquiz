<html lang="eng">
<head>
     <meta name="viewport" content="width=device-width,initial-scale=1"> 
     <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">	 	
</head>
<style>
  body{
	  background-image:url("edu2.jpg");
	  background-repeat: no-repeat;
	  background-size: 100% 100%;
	  opacity:0.7;
  }
</style>
<body>
<jsp:include page="header.jsp"/>
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">Home</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav nav-pills">
			 <li class="active" ><a href="#CoreJava">J2SE</a></li>
			 <li><a href="#AdvJava">J2EE</a></li>
			 <li><a href="#DS">Data Structure</a></li>
			 <li><a href="#Quiz">Java Quizes</a></li>
			 <li><a href="#dsquiz">DS Quizes</a></li>
			 <li><a href="#Interview">Interview</a></li>
             <li><a href="#Contact">Contact</a></li>			 
      </ul>
    </div>
  </div>
</nav>



<div id="home" class="">
</div>


<div id="CoreJava" class="">
<em>Basics:<em>

</div>



<div id="AdvJava" class="">

</div>



<div id="DS" class="">
</div>


<div id="Quiz" class="">
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



<div id="dsquiz" class="">

</div>



<div id="Interview" class="">

</div>


<div id="Contact" class="">

</div>


</body>
</html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>  
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
