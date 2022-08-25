<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Log in unsuccessful!</title>
</head>
<body>
<%@ page import ="java.sql.*" %>
<%
    String username = request.getParameter("user");   
    String pwd = request.getParameter("pass");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/UniversityRegistration","root", "Y3llowBlu3F!sh");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from users where username='" + username + "' and pass='" + pwd + "'");
    if (rs.next()) {
        session.setAttribute("user", username); // the username will be stored in the session
        String type = rs.getNString(4);
        if (type.equals("student")){
        	response.sendRedirect("student.jsp");
        }else if (type.equals("prof")){
        	session.setAttribute("pid", rs.getInt("uid"));
        	response.sendRedirect("courses.jsp");
        }else if (type.equals("admin")) {
        	response.sendRedirect("admin.jsp");
        }
    } else {
        out.println("Invalid credentials <a href='login.jsp'>try again</a>");
    }
%>
</body>
</html>