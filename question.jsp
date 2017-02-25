<%@ page import="java.sql.*"%>
<% String database=request.getParameter("db");
   String table=request.getParameter("tablenum"); 
   String ID=request.getParameter("quesnum");
   int i=0;
    String p=null,question=null,opt1=null,opt2=null,opt3=null,opt4=null;
    String DRIVER="jdbc:mysql://localhost:3306/"+database;
    Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(DRIVER, "root", "");
	String sql="select * from "+table+ " where id=?";
	PreparedStatement st=con.prepareStatement(sql);
    st.setString(1, ID);
    ResultSet rs=st.executeQuery();
    while(rs.next()){
    p=rs.getString("id");
	question=rs.getString("ques");
	opt1=rs.getString("opt1");
	opt2=rs.getString("opt2");
	opt3=rs.getString("opt3");
	opt4=rs.getString("opt4");
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
		    Q. <%=ID%><hr/>
			 <p>
               <%=question%>			 
			 </p>
			 <hr/>
			 
			 A   <input type="radio" id="A" name="gender" value="A"> <%=opt1%></input><br/>
             B   <input type="radio" id="B" name="gender" value="B"> <%=opt2%></input><br/>
             C   <input type="radio" id="C" name="gender" value="C"> <%=opt3%></input><br/>
			 D   <input type="radio" id="D" name="gender" value="D"> <%=opt4%></input><br/> 
			 <hr/>
			 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>  
             <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
</body>
</html>			 