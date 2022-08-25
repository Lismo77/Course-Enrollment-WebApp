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
<title>Professor - Course Section - Student List</title>
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

	// Make SELECT query to select students enrolled for the course section
	String sql = "SELECT * FROM enrollment e, students s WHERE e.sid = s.sid AND e.cid=? AND e.section=?";

	// Create a SQL statement
	PreparedStatement stmt = con.prepareStatement(sql);
	stmt.setString(1, cid);
	stmt.setString(2, section);
	
	// Run the query to get the result
	ResultSet result = stmt.executeQuery();
%>

  <h3>Students of Course <%= cid %> - Section <%= section %></h3>

  <table cellpadding="5" border="1">
  	<tr>
  		<th>Student ID</th>
  		<th>Student Name</th>
  		<th>Phone</th>
  		<th>Grade</th>
  	</tr>
<%
	// Parse out the results
	while (result.next()) {		
		int studentId = result.getInt("sid");
		String grade = result.getString("grade");
		if (grade == null) {
			grade = "";
		}
%>
	<tr>
  		<td><%= studentId %></td>
  		<td><%= result.getString("sname") %></td>
  		<td><%= result.getString("phone") %></td>
  		<td>
  			<form action="updateGrade.jsp" method="POST">
  				<input name="grade" value="<%= grade %>" size="4">
  				<input name="cid" type="hidden" value="<%= cid %>">
  				<input name="section" type="hidden" value="<%= section %>">
  				<input name="studentId" type="hidden" value="<%= studentId %>">
  				<input type="submit" value="Submit">
  			</form>
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