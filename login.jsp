<%@ page import="java.sql.*" %>
<%
String password=request.getParameter("InputPassword1");
String email1=request.getParameter("InputEmail1");
String p=null;
Class.forName("com.mysql.jdbc.Driver");  
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/don", "root", ""); 
PreparedStatement st=con.prepareStatement("select * from user where email=?");
st.setString(1, email1);
ResultSet rs=st.executeQuery();
while(rs.next()){
p=rs.getString("name");
}
session.setAttribute("user",p);
%><jsp:forward page="quiz.jsp" />