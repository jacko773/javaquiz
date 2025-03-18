<%@ page import = "java.util.Properties"%>
<%@ page import = "javax.mail.*"%>
<%@ page import = "javax.mail.internet.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Random"%>
<%@ page import="java.sql.*" %>
<%
	Random rand = new Random();
	final String to=request.getParameter("to");
	final int tocken=rand.nextInt(100000);
%>
<% 
	Class.forName("com.mysql.jdbc.Driver");
	System.out.println("driver loaded ");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/user", "root", "root");	   
	Statement st=con.createStatement();
	String sql="update user1 SET  TOCKEN='"+tocken+"' where EMAIL='"+to+"'";
	out.print(sql);
	st.executeUpdate(sql);
%>
<%
	final String msg="<div><font color='green'>vinay</font></div><br/>http://localhost:8080/javaquiz3/newpassword.jsp?tocken="+tocken;  
	final String sub="javaQuiz password reset link sending m,ail to test GITHUB_API integration";   
	final String from="vinay18011@gmail.com";
	final String password="Vinay308080@";
	Properties props = new Properties();    
          props.put("mail.smtp.host", "smtp.gmail.com");    
          props.put("mail.smtp.socketFactory.port", "465");    
          props.put("mail.smtp.socketFactory.class",    
                    "javax.net.ssl.SSLSocketFactory");    
          props.put("mail.smtp.auth", "true");    
          props.put("mail.smtp.port", "465");      
          Session session1 = Session.getInstance(props,    
           new javax.mail.Authenticator() {    
           protected PasswordAuthentication getPasswordAuthentication() {    
           return new PasswordAuthentication(from,password);  
           }    
          });   
try{		  
           MimeMessage message = new MimeMessage(session1);    
           message.addRecipient(Message.RecipientType.TO,new InternetAddress(to,"UTF-8"));    
           message.setSubject(sub,"UTF-8");    
           message.setText(msg,"UTF-8","html");    
           Transport.send(message);	
}catch(Exception e){
	
}		   
%><jsp:forward page="index.jsp" />
