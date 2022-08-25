<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
// Valid login session first:
// - If professor logged in, the session shall contain "professorId" attribute
if (session.getAttribute("pid") == null) {
	// Professor ID is not set, redirect to login page
	response.sendRedirect("login.jsp");
	return;
}

// Get the professor ID and name (from session's attributes)
Integer professorId = (Integer) session.getAttribute("pid");
String professorName = (String) session.getAttribute("user");
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Professor - My Courses</title>
</head>
<body>
  
  <p>
 	Welcome, Professor <b><%= professorName %></b> (ID: <%= professorId %>)!
 	<a href="logout.jsp">Logout</a>
  </p>

<%
try {
	// Get the database connection
	db db = new db();	
	Connection con = db.getConnection();
	
	// Create a SQL statement
	Statement stmt = con.createStatement();
	
	// Make SELECT query to select all sections that are assigned to the professor
	String sql = "SELECT * FROM sections s, courses c WHERE s.cid = c.cid AND pid=" + professorId;
	
	// Run the query to get the result
	ResultSet result = stmt.executeQuery(sql);	
%>
  
  <h3>Course List</h3>
  <table cellpadding="5" border="1">
  	<tr>
  		<th>Course ID</th>
  		<th>Course Name</th>
  		<th>Section Number</th>
  		<th>Department</th>
  		<th>Schedule</th>
  		<th>Students</th>
  	</tr>
<%
	// Parse out the results
	while (result.next()) {
		int cid = result.getInt("cid");
		int section = result.getInt("section");
%>
	<tr>
  		<td><%= cid %></td>
  		<td><%= result.getString("cname") %></td>
  		<td><%= section %></td>
  		<td><%= result.getString("department") %></td>
  		<td>
  			<a href="courseSchedule.jsp?cid=<%= cid %>&section=<%= section %>">Class Schedule</a>
  		</td>
  		<td>
  			<a href="courseStudents.jsp?cid=<%= cid %>&section=<%= section %>">Student List</a>
  		</td>
  	</tr>
		
<%
	}
%>
  </table>
<%
	//Close the connection
	con.close();

} catch (Exception ex) {
	out.print(ex);
	out.print("Select failed :()");
}
%>
</body>
</html>