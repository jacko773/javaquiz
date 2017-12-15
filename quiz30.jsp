<%@ page import="java.sql.*" %>  
<%
	String database=request.getParameter("test");
	String DRIVER="jdbc:mysql://localhost:3306/"+database;
	String USER="root";
	String PASSWORD="root";
	int count=0;
	Class.forName("com.mysql.jdbc.Driver");
	System.out.println("driver loaded ");
	Connection con = DriverManager.getConnection(DRIVER, USER, PASSWORD);  
	Statement st=con.createStatement();
	String sql="show tables";
	ResultSet rs =st.executeQuery(sql);
%>
<!DOCTYPE html>
<html lang="eng">
<head>
     <meta name="viewport" content="width=device-width, initial-scale=1">  
     <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	 <link rel="stylesheet" href="quiz.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>  
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script> 	 
<script>

 $(document).ready(function(){	
 if("<%=request.getParameter("test")%>"=="cj30"){ 
        $('#contentsec').html('<br/>'+
		'<center style="font-size:20px;"><b ><em style="color:white">Core  Java  Quizes</em></b><br/><br/><em>with best questions <br/>for any <br/>java test<br/> or<br/> certification</em><center>'+
		'<br/>'
        );
		$('.sidebarheader').html('<br/>'+	
		'<center><label><em>Core Java 30 minutes quiz</em></label></center>'
        );	
		
        		
	  } 

     if("<%=request.getParameter("test")%>"=="cj60"){ 
		$('.sidebarheader').html('<br/>'+
		'<b>core java 60 minutes quiz</b>'+
		'<br/>'
        );		
	  }

     if("<%=request.getParameter("test")%>"=="cj120"){ 
		$('.sidebarheader').html('<br/>'+
		'<b>core java 120 minutes quiz</b>'+
		'<br/>'
        );		
	  }


     if("<%=request.getParameter("test")%>"=="aj30"){ 
		$('.sidebarheader').html('<br/>'+
		'<b>advance java 30 minutes quiz</b>'+
		'<br/>'
        );		
	  }	  
	  
	  if("<%=request.getParameter("test")%>"=="aj60"){ 
		$('.sidebarheader').html('<br/>'+
		'<b>advance java 60 minutes quiz</b>'+
		'<br/>'
        );		
	  }
	  
	  if("<%=request.getParameter("test")%>"=="aj120"){ 
		$('.sidebarheader').html('<br/>'+
		'<b>advance java 120 minutes quiz</b>'+
		'<br/>'
        );		
	  }
   });
</script>	
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="fluid-container">
     <div class="col-md-2" id="sidebar" style="border-right:1px black solid">
	 <div class="sidebarheader">
	 
	 </div>
	 
	<div class="sidebarnav">
	     <hr/>
		 <center>
		 <%while(rs.next()){%>
		 
        <a href="quizstart.jsp?db=<%=request.getParameter("test")%>&tablenum=q<%=++count%>">java quiz<%=count%></a><hr/>
		<%
		}
		%>
		</center>
	</div>    
	 </div>
     
<div class="col-md-10" id="contentsect"  >
	 
<div >     

<div class="jumbotron" style="background-color:#566573">
     <div class="container" id="contentsec">
	 
     </div>

</div>
</div>
</div>	 
</div>
<script>

</body>
</html>
