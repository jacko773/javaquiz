<%@ page import="java.sql.*"%>
<% 
    String DRIVER="jdbc:mysql://localhost:3306/";
    Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(DRIVER, "root", "root");
	String sql="create DATABASE aj120";
	Statement st=con.createStatement();
	int i=st.executeUpdate(sql);
	if(i==1)
		System.out.println("database created");
	else
		System.out.println("some Error occure");
%>
<%--//user
	//project
	//cj30
	//
 --%>