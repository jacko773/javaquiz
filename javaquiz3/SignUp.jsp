<%@ page import="java.sql.*" %>  

<% 
String name=request.getParameter("user");
String email=request.getParameter("InputEmail2");
String password=request.getParameter("Userpass");
String cpassword=request.getParameter("InputPassword3
	System.out.println("driver loaded ");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/user", "root", "root");
	System.out.println("Connection establish");
	   
Statement st=con.createStatement();
String sql="insert into user1(USER,EMAIL,PASSWORD ) values('"+name+"','"+email+"','"+password+"')";
int i = st.executeUpdate(sql);
if(i>0){
%>
}else{
%>
	</script>
<%
}
%><jsp:forward page="signin.jsp" />
