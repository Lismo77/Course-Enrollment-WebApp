<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
<body>
<header><h1>Welcome <%=session.getAttribute("user")%>!</h1></header>
<br>
To view the courses you have taken, click the button below.
<br><br>
<%
  Class.forName("com.mysql.jdbc.Driver");
  db studentdb = new db();
  Connection con = studentdb.getConnection();
  Statement st = con.createStatement();
  ResultSet rs;
  rs = st.executeQuery("select * from users where username='"+session.getAttribute("user")+"'");
  int sid = -1;
  if(rs.next()) sid = rs.getInt(3);
  else{
	  session.invalidate();
	  response.sendRedirect("login.jsp");
  }
  session.setAttribute("sid", sid+"");
%>
<form method="get" action="registration.jsp">
	<input type="submit" value="View Registration"/>
</form>
<br><br>
To register for a course, click the button below.
<br><br>
<form method = "get" action = "register.jsp">
<input type = "submit" value = "View Courses"></form>
<br><br>
<form method="get" action="logout.jsp">
<input type="submit" value="Log out"/>
</form>
</body>
</html>