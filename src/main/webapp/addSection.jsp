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
<title>Add Section Page</title>
</head>
<body>
<a href='logout.jsp'>Logout</a>
<br>
	<form method="post" action="newSection.jsp">
	<table>
	<tr>    
	<td>Section #</td><td><input type="text" name="sectid"></td>
	</tr>
	<tr>
	<td>Meeting time:</td><td>Day:<input type="text" name="meetday">Start Time (hh:mm:ss):<input type="text" name="timefrom">End time (hh:mm:ss):<input type="text" name="timeto"></td>
	</tr>
	<tr>
	<td>Professor ID</td><td><input type="text" name="pid"></td>
	</tr>
	</table>
	<input type="hidden" value="<%= request.getParameter("cid") %>" name="cid" />
	<input type="submit" value="Add me!">
	</form>
</body>
</html>