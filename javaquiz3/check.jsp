	<%
	String to="vinay18011@gmail.com";
	int tocken=1234;
	String sql="update user1 SET  TOCKEN="+tocken+" where EMAIL="+to;
	out.print(sql);
	%>