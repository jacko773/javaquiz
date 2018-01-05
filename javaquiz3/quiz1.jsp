<html lang="eng">
<head>
     <meta name="viewport" content="width=device-width,initial-scale=1"> 
     <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">	
	<link rel="stylesheet" href="style.css">
</head>
<style>
body{
	background-image:url("ed.jpg");
	background-repeat: no-repeat;
	background-size: 100% 100%;
	opacity:0.7;
	overflow:hidden;
 }
#testt{
	display:box;
	min-width:100px;
	background-color:#DCDCDC;
	margin-top:10px;
	height:60px;
}
#testt > a{
	test-alignment:middle;
}
#home{
	margin-top:-20px;
	width:100%;
	height:100%;
	background:#202A36;
	color:white;
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
     
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
			 <li class="active"><a class="navbar-brand" href="#" onclick="displaycontent('home')">Home</a></li>
			 <li><a href="#CoreJava" id="#CoreJava" onclick="displaycontent('CoreJava')">J2SE</a></li>
			 <li><a href="#AdvJava" id="#AdvJava" onclick="displaycontent('AdvJava')">J2EE</a></li>
			 <li><a href="#" id="#DS" onclick="displaycontent('DS')">Data Structure</a></li>
			 <li><a href="#" id="#Quiz" onclick="displaycontent('Quiz')">Java Quizes</a></li>
			 <li><a href="#" id="#dsquiz" onclick="displaycontent('dsquiz')">DS Quizes</a></li>
			 <li><a href="#" id="#Interview" onclick="displaycontent('Interview')">Interview</a></li>
             <li><a href="#" id="#Contact" onclick="displaycontent('Contact')">Contact</a></li>			 
      </ul>
    </div>
  </div>
</nav>

<div class="content">


<div id="home" class="item">
	<div class="container">
		<div class="row">
			<div class="col-md-10">
				dfjgiuerhgre
			</div>
			<div class="col-md-2">
			dfhbidfuhb
			</div>
		</div>
	</div>
</div>


<div id="CoreJava" class="item" style="display:none">
<div class="wrapper">
	<div class="fluid-container">
		<div class="row">
			<div class="col-md-2">
				<nav id="sidebar">
					<!--<div class="sidebar-header">
						<h3>Core java</h3>
					</div>
					-->
					<ul class="list-unstyled components">
					<li>
						  <a href="#" data-toggle="collapse" data-target="#demo">Home</a>
						  <ul id="demo" class="collapse list-unstyled">
								<li><a href="#">Page</a></li>
								<li><a href="#">Page</a></li>
								<li><a href="#">Page</a></li>
						  </ul>
					</li>
					<li><a href="#">About</a></li>
					<li>
						<a href="#"  data-toggle="collapse" data-target="#demo1">Pages</a>
						<ul id="demo1" class="collapse list-unstyled">
								<li><a href="#">Page</a></li>
								<li><a href="#">Page</a></li>
								<li><a href="#">Page</a></li>
						</ul>
					</li>
						<li><a href="#">Portfolio</a></li>
						<li><a href="#">Contact</a></li>
					</ul>
				</nav>
			</div>
			<div class="col-md-10">
				<div id="content">
					
				</div>
			</div>
		</div>
	</div>
</div>

</div>



<div id="AdvJava" class="item" style="display:none">
	<div class="fluid-container">
		<div class="row">
			<div class="col-md-2">
				<table class="table" style="border:1px solid DarkGrey">
					<tr>
						<td>
							<a href="#">Introduction</a>
						</td>
					</tr>
					<tr>
						<td>
							<a href="#">Basics</a>
						</td>
					</tr>
				</table>
			</div>
			<div class="col-md-10">
			</div>
		</div>
	</div>
</div>



<div id="DS" class="item" style="display:none">
	<div class="fluid-container">
		<div class="row">
			<div class="col-md-2">
				<table class="table" style="border:1px solid DarkGrey">
					<tr>
						<td>
							<a href="#">Introduction</a>
						</td>
					</tr>
					<tr>
						<td>
							<a href="#">Basics</a>
						</td>
					</tr>
				</table>
			</div>
			<div class="col-md-10">
			</div>
		</div>
	</div>
</div>


<div id="Quiz" class="item" style="display:none">
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



<div id="dsquiz" class="item" style="display:none">
dsquiz
dsquiz
dsquiz
dsquiz
dsquiz
dsquiz
</div>



<div id="Interview" class="item" style="display:none">
Interview
Interview
Interview
Interview
Interview
Interview
</div>


<div id="Contact" class="item" style="display:none">
Contact
Contact
Contact
Contact
Contact
Contact
</div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>  
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script>
	$("li").click(function(){
		$("li").removeClass("active");
		$(this).addClass("active");
	});
	function displaycontent(contents) {
		var i;
		var x = document.getElementsByClassName("item");
		for (i = 0; i < x.length; i++) {
			x[i].style.display = "none"; 
		}
		document.getElementById(contents).style.display = "block"; 
	}
</script>
	<script>
		$(document).ready(function () {

    $('#sidebarCollapse').on('click', function () {
        $('#sidebar').toggleClass('active');
    });

});
	</script>

</body>
</html>

