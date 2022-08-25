<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>New admin</title>
</head>
<body>
<a href='logout.jsp'>Logout</a>
<br>
	<%
	

		try {

		//Get the database connection
		db admindb = new db();	
		Connection con = admindb.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the index.jsp
		String newUsername = request.getParameter("username");
		String newPassword = request.getParameter("pass");
		int newAid = Integer.parseInt(request.getParameter("aid"));
		String newDepartment = request.getParameter("dept");

		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO users(username, pass, uid, utype)"
		+ "VALUES (?,?,?,?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, newUsername);
		ps.setString(2, newPassword);
		ps.setInt(3, newAid);
		ps.setString(4, "admin");
		ps.executeUpdate();
		
		//Make an insert statement for the Sells table:
		insert = "INSERT INTO admins(aid, dept)"
		+ "VALUES (?,?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		ps = con.prepareStatement(insert);
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself		
		ps.setInt(1, newAid);
		ps.setString(2, newDepartment);
		ps.executeUpdate();
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("insert succeeded");
		
			} catch (Exception ex) {
		out.print(ex);
		out.print("insert failed");
			}
	%>
	<br>
	<a href='admin.jsp'>Back to home</a>
</body>
</html>