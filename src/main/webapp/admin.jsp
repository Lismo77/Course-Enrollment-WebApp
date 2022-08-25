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
<title>Admin Page</title>
</head>
<body>
<%
    if ((session.getAttribute("user") == null)) {
%>
You are not logged in<br/>
<a href="login.jsp">Please Login</a>
<%} else {
%>
<h3>Welcome <%=session.getAttribute("user")%>!</h3>
<a href='logout.jsp'>Log out</a>
<%List<String> list = new ArrayList<String>();

try {

	//Get the database connection
	db userdb = new db();	
	Connection con = userdb.getConnection();	
	
	//Create a SQL statement
	Statement deptstmt = con.createStatement();
	Statement userstmt = con.createStatement();
	//Make a SELECT query
	String deptquery = "SELECT A.dept FROM admins A, users U WHERE U.username='" + session.getAttribute("user") 
		+ "' AND U.uid=A.aid";
	String userquery = "SELECT * FROM users";
	
	//Run the query against the database.
	ResultSet deptresult = deptstmt.executeQuery(deptquery);
	ResultSet usertable = userstmt.executeQuery(userquery);
	
	String dept = "";
	if (deptresult.next()) {
		dept = deptresult.getString("dept");
	}
	
	Statement coursestmt = con.createStatement();
	String coursesquery = "SELECT * FROM courses WHERE department='" + dept + "'";
	ResultSet coursestable = coursestmt.executeQuery(coursesquery);
	
	out.print("<div>");
	out.print("<div>");
	
	out.print("<h4>All users:</h4>");

	//Make an HTML table to show the results in:
	out.print("<table>");

	//make a row
	out.print("<tr>");
	//make a column
	out.print("<td class="  + '"' + "thead" + '"' + '>');
	//print out column header
	out.print("username");
	out.print("</td>");
	//make a column
	out.print("<td class="  + '"' + "thead" + '"' + '>');
	out.print("password");
	out.print("</td>");
	//make a column
	out.print("<td class="  + '"' + "thead" + '"' + '>');
	out.print("uid");
	out.print("</td>");
	//make a column
	out.print("<td class="  + '"' + "thead" + '"' + '>');
	out.print("utype");
	out.print("</td>");
	out.print("</tr>");

	//parse out the results
	while (usertable.next()) {
//make a row
out.print("<tr>");
//make a column
out.print("<td>");
//Print out current username:
out.print(usertable.getString("username"));
out.print("</td>");
out.print("<td>");
//Print out current password:
out.print(usertable.getString("pass"));
out.print("</td>");
out.print("<td>");
//Print out current user id
out.print(usertable.getString("uid"));
out.print("</td>");
out.print("<td>");
//Print out current user type
out.print(usertable.getString("utype"));
out.print("</td>");
out.print("</tr>");
	}
	out.print("</table>");
	out.print("</div>");
	
%>
	<br>
		<form method="post" action="checkNewUser.jsp">
			<input type="radio" name="command" value="student"/>Student
			<br>
			<input type="radio" name="command" value="professor"/>Professor
		  	<br>
		  	<input type="radio" name="command" value="admin"/>Admin
		  	<br>
		  	<input type="submit" value="Add User" />
		</form>
	<br>
<%
	
	//courses table
	out.print("<div>");
	
	out.print("<h4>Courses in the " + dept + " department:</h4>");
	out.print("<table>");

	//make a row
	out.print("<tr>");
	//make a column
	out.print("<td class="  + '"' + "thead" + '"' + '>');
	//print out column header
	out.print("course name");
	out.print("</td>");
	//make a column
	out.print("<td class="  + '"' + "thead" + '"' + '>');
	out.print("course id");
	out.print("</td>");
	//make a column
	out.print("<td class="  + '"' + "thead" + '"' + '>');
	out.print("credits");
	out.print("</td>");
	out.print("</tr>");

	//parse out the results
	while (coursestable.next()) {
//make a row
out.print("<tr>");
//make a column
out.print("<td>");
//Print out current username:
out.print(coursestable.getString("cname"));
out.print("</td>");
out.print("<td>");
//Print out current password:
out.print(coursestable.getString("cid"));
out.print("</td>");
out.print("<td>");
//Print out current user id
out.print(coursestable.getString("credits"));
out.print("</td>");
out.print("<td>");
//Print out current user id
out.print("<form method=" + '"' + "post" + '"' + " action=" + '"' + "viewSection.jsp" + '"' + '>' +
"<input type=" + '"' + "hidden" + '"' + " value=" + '"' + coursestable.getString("cid") + '"' + " name=" + '"' + "courseid" + '"' + "/>" +
"<input type=" + '"' + "submit" + '"' + " value=" + '"' + "View Section" + '"' + "/>" +
"</form>");
out.print("</td>");
	}
	out.print("</table>");
	out.print("</div>");
	
	%>
	<br>
		<form method="post" action="addCourse.jsp">
			<input type="hidden" value="<%out.print(dept); %>" name="department" />
			<input type="submit" value="Add Course" />
		</form>
	<br>
	<%
	
	out.print("</div>");

	//close the connection.
	con.close();

} catch (Exception e) {
} %>
<%
    }
%>
</body>
</html>