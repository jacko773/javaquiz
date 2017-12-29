<%@ page import="java.sql.*" %>
<% 
	String tocken=request.getParameter("tocken");
	String pass=request.getParameter("password");
	Class.forName("com.mysql.jdbc.Driver");
	System.out.println("driver loaded ");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/user", "root", "root");	   
	Statement st=con.createStatement();
	String sql="update user1 SET  PASSWORD='"+pass+"' where TOCKEN='"+tocken+"'";
	out.print(sql);
	st.executeUpdate(sql);
%>