<%@ page import="java.sql.*" %>
<%
String password=request.getParameter("InputPassword1");
String email1=request.getParameter("InputEmail1");
String p=null;
	 String DRIVER="jdbc:mysql://localhost:3306/user";
	 String USER="root";
	 String PASSWORD="root";
Class.forName("com.mysql.jdbc.Driver");  
Connection con=DriverManager.getConnection(DRIVER, USER, PASSWORD); 
PreparedStatement st=con.prepareStatement("select * from user1 where email=?");
st.setString(1, email1);
ResultSet rs=st.executeQuery();
while(rs.next()){
p=rs.getString("USER");
}
session.setAttribute("USER",p);
%><jsp:forward page="quiz1.jsp" />

