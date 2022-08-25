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
<title>Add Course Page</title>
</head>
<body>
<a href='logout.jsp'>Logout</a>
<br>
	<form method="post" action="newCourse.jsp">
	<table>
	<tr>    
	<td>Course ID</td><td><input type="text" name="cid"></td>
	</tr>
	<tr>
	<td>Course Name</td><td><input type="text" name="cname"></td>
	</tr>
	<tr>
	<td>Credits</td><td><input type="text" name="credits"></td>
	</tr>
	</table>
	<input type="hidden" value="<%= request.getParameter("department") %>" name="department" />
	<input type="submit" value="Add me!">
	</form>
</body>
</html>