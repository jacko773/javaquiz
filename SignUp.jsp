<%@ page import="java.sql.*" %>  

<% 
String name=request.getParameter("user");
String email=request.getParameter("InputEmail2");
String password=request.getParameter("InputPassword2");
String cpassword=request.getParameter("InputPassword3");

	Class.forName("com.mysql.jdbc.Driver");
	System.out.println("driver loaded ");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/don", "root", "");
	System.out.println("Connection establish");
	   
Statement st=con.createStatement();
String sql="insert into user(name,email,password) values('"+name+"','"+email+"','"+password+"')";
int i = st.executeUpdate(sql);
if(i>0){
	out.println("singnup done");
}else{
	out.println("something wrong");
}
	
%><jsp:forward page="quiz.jsp" />