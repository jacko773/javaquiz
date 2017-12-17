<%@ page import="java.sql.*"%>
<% 
  String DRIVER="jdbc:mysql://localhost:3306/cj30";
	 String USER="root";
	 String PASSWORD="root";
    Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(DRIVER, USER,PASSWORD);
String sql="create TABLE  q3(ID int AUTO_INCREMENT,QUESTION varchar(300) NOT NULL ,OPTA varchar(10) NOT NULL,OPTB varchar(10) NOT NULL,OPTC varchar(10) NOT NULL,OPTD varchar(10) NOT NULL,ANS varchar(10) NOT NULL,PRIMARY KEY(ID))";
	Statement st=con.createStatement();
	int i=st.executeUpdate(sql);
	if(i>0)
		out.print("table created");
	else
		out.print("some Error occure");
%>
