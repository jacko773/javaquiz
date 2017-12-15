<%@ page import="java.sql.*"%>
<% String database=request.getParameter("db");
   String table=request.getParameter("tablenum");
   String ID1=request.getParameter("quesnum");
   int i=0;
    String p=null,question=null,opt1=null,opt2=null,opt3=null,opt4=null;
    String DRIVER="jdbc:mysql://localhost:3306/"+database;
    Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(DRIVER, "root", "root");
	String sql="select * from "+table+" where ID="+ID1;
	PreparedStatement st=con.prepareStatement(sql);
    ResultSet rs=st.executeQuery();
    while(rs.next()){
    p=rs.getString("ID");
	question=rs.getString("QUESTION");
	opt1=rs.getString("OPTA");
	opt2=rs.getString("OPTB");
	opt3=rs.getString("OPTC");
	opt4=rs.getString("OPTD");
}
%>
 <!DOCTYPE html>  
<html lang="en">  
<head>  
  <title></title>  
  <meta name="viewport" content="width=device-width, initial-scale=1">  
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">     
</head>
<br/>
		 <br/>
		    Q. <%=ID1%><hr/>
			 <p>
               <%=question%>			 
			 </p>
			 <hr/>
			 
			 A:  <input type="radio" id="A" name="gender" value="A"> <%=opt1%></input><br/>
             B:  <input type="radio" id="B" name="gender" value="B"> <%=opt2%></input><br/>
             C:  <input type="radio" id="C" name="gender" value="C"> <%=opt3%></input><br/>
			 D:  <input type="radio" id="D" name="gender" value="D"> <%=opt4%></input><br/> 
			 <hr/>
			 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>  
             <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
</body>
</html>			 
