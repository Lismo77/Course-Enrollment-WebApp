<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
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
<title>Professor - Course Section - Update Grade</title>
</head>
<body>
  
  <p>
 	Welcome, Professor <b><%= professorName %></b> (ID: <%= professorId %>)!
 	<a href="logout.jsp">Logout</a>
  </p>
  <p><a href="courses.jsp">Course List</a></p>

<%
try {
	//Get the database connection
	db db = new db();
	Connection con = db.getConnection();

	//Get parameters from the HTML form for updating student grade
	String cid = request.getParameter("cid");
	String section = request.getParameter("section");
	String studentId = request.getParameter("studentId");
	String grade = request.getParameter("grade");

	// SQL query to update the student's grade
	String sql = "UPDATE enrollment SET grade = ? WHERE cid=? AND section=? AND sid=?";
	
	// Prepare the SQL statmentn for the update
	PreparedStatement ps = con.prepareStatement(sql);

	//Add parameters of the query
	ps.setString(1, grade);
	ps.setString(2, cid);
	ps.setString(3, section);
	ps.setString(4, studentId);
	
	// Run the query against the DB
	ps.executeUpdate();

	// Close the connection
	con.close();
%>

<h3>Grade Updated</h3>
<ul>
	<li>Course: <%= cid %></li>
	<li>Section: <%= section %></li>
	<li>Student ID: <%= studentId %></li>
	<li>Grade: <%= grade %></li>
</ul>
<p><a href="courseStudents.jsp?cid=<%= cid %>&section=<%= section %>">Go back to Student List</a></p>

<%	
} catch (Exception ex) {
	out.print(ex);
	out.print("Update failed :()");
}
%>
</body>
</html>