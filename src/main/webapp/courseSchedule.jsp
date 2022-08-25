<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
//Valid login session first:
//- If professor logged in, the session shall contain "professorId" attribute
if (session.getAttribute("pid") == null) {
	// Professor ID is not set, redirect to login page
	response.sendRedirect("login.jsp");
	return;
}

//Get the professor ID and name (from session's attributes)
Integer professorId = (Integer) session.getAttribute("pid");
String professorName = (String) session.getAttribute("user");
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Professor - Course Section - Class Schedule</title>
</head>
<body>
  
  <p>
 	Welcome, Professor <b><%= professorName %></b> (ID: <%= professorId %>)!
 	<a href="logout.jsp">Logout</a>
  </p>
  <p><a href="courses.jsp">Course List</a></p>
  
<%
// Section No of the CourseOffering to view student list
String cid = request.getParameter("cid");
String section = request.getParameter("section");

try {
	// Get the database connection
	db db = new db();
	Connection con = db.getConnection();

	// Make SELECT query to select ClassSchedule of the course section
	String sql = "SELECT * FROM meets WHERE cid=? AND section=?";

	// Create a SQL statement
	PreparedStatement stmt = con.prepareStatement(sql);
	stmt.setString(1, cid);
	stmt.setString(2, section);
	
	// Run the query to get the result
	ResultSet result = stmt.executeQuery();
%>

  <h3>Class of Course <%= cid %> - Section <%= section %></h3>

  <table cellpadding="5" border="1">
  	<tr>
  		<th>Day of week</th>
  		<th>Start Time</th>
  		<th>End Time</th>
  	</tr>
<%
	// Parse out the results
	while (result.next()) {
%>
	<tr>
  		<td><%= result.getString("mday") %></td>
  		<td><%= result.getString("timefrom") %></td>
  		<td><%= result.getString("timeto") %></td>
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