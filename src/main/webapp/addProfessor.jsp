<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="styles.css">
<meta charset="ISO-8859-1">
<title>Add Professor Page</title>
</head>
<body>
<a href='logout.jsp'>Logout</a>
<br>
	<form method="post" action="newProfessor.jsp">
	<table>
	<tr>    
	<td>Professor Name</td><td><input type="text" name="pname"></td>
	</tr>
	<tr>    
	<td>Username</td><td><input type="text" name="username"></td>
	</tr>
	<tr>
	<td>Password</td><td><input type="password" name="pass"></td>
	</tr>
	<tr>    
	<td>Phone</td><td><input type="text" name="phone"></td>
	</tr>
	<tr>
	<td>Professor ID</td><td><input type="text" name="pid"></td>
	</tr>
	<tr>
	<td>Office</td><td><input type="text" name="office"></td>
	</tr>
	</table>
	<input type="submit" value="Add me!">
	</form>
</body>
</html>