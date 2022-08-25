<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
   <head>
      <title>Login Form</title>
   </head>
   <body>
     <form action="checkLoginDetails.jsp" method="POST">
       <br>Username: <input type="text" name="user"/> <br/>
       <br>Password: <input type="password" name="pass"/> <br/>
       <br><input type="submit" value="Submit"/><br/>
     </form>
   </body>
</html>