<%@ page import="java.sql.*"%>
<% 
    String DRIVER="jdbc:mysql://localhost:3306/cj30";
    Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(DRIVER, "root", "root");
	String sql="delete table q2";
	Statement st=con.createStatement();
	int i=st.executeUpdate(sql);
	if(i==1)
		System.out.println("database created");
	else
		System.out.println("some Error occure");
%>