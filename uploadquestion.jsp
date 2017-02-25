<%@ page import="java.sql.*"%>
<% String database=request.getParameter("dbselect");
   String table=request.getParameter("quizno");
   String ques =request.getParameter("ques");
   String opt1 =request.getParameter("opt1");
   String opt2 =request.getParameter("opt2");
   String opt3 =request.getParameter("opt3");
   String opt4 =request.getParameter("opt4");
   String ans  =request.getParameter("ans");
   String explanation =request.getParameter("explanation");
   String DRIVER="jdbc:mysql://localhost:3306/"+database;
   Class.forName("com.mysql.jdbc.Driver");
   Connection con = DriverManager.getConnection(DRIVER, "root", "");
   String vals="values('"+ques+"','"+opt1+"','"+opt2+"','"+opt3+"','"+opt4+"','"+ans+"','"+explanation+"')";
   String sql="insert into "+table+"(ques,opt1,opt2,opt3,opt4,ans,explanation)"+vals ;
   Statement stmt=con.createStatement(); 
   int result=stmt.executeUpdate(sql);
%>
<jsp:forward page="admin.jsp" />