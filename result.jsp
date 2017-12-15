<%@ page import="java.sql.*" %>
<%
String args=request.getParameter("myArray");
String arr[]=args.split(",");
String database=request.getParameter("db");
String tb=request.getParameter("tb");
int count=0;
	String DRIVER="jdbc:mysql://localhost:3306/"+database;
	String USER="root";
	String PASSWORD="root";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(DRIVER, USER, PASSWORD);
	Statement st=con.createStatement();
%>

<html>
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<table class="table table-striped">
	<tr>
		<td>quesno</td>
		<td>your answer</td>
		<td>answer</td>
		<td>mark obtain</td>
		<td>total marks</td>
	</tr>
<% for(int i=1;i<arr.length;i++){
		String sql="select ans from "+tb+" where ID="+i;
		ResultSet rs =st.executeQuery(sql);
		while(rs.next()){
		String ans1=rs.getString("ans");
		String ans2=arr[i];
%>
	<tr>
		<td><%=i%></td>
		<td><%=arr[i]%></td>
		<td><%=(String)rs.getString("ans")%></td>
		<%if(ans1.equals(ans2)){%>
			<%count=count+1;%>
			<td>+1</td>

		<%}else{%>
			<td>-1</td>
			<%count=count-1;%>
		<%}%>
		<td><%=count%></td>
	</tr>
<%}
}
%>
</table>
<center><h1>Total marks obtained</h1><h1><%=count%></h1></center>
</html>
