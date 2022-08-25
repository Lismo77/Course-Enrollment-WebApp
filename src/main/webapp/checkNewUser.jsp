<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Check user type</title>
</head>
<body>
<%@ page import ="java.sql.*" %>
<%
    String type = request.getParameter("command");
    if (type.equals("student")){
    	response.sendRedirect("addStudent.jsp");
    }else if (type.equals("professor")){
    	response.sendRedirect("addProfessor.jsp");
    }else response.sendRedirect("addAdmin.jsp");
%>
</body>
</html>