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
<%
try {

	//Get the database connection
	db userdb = new db();	
	Connection con = userdb.getConnection();	
	
	//Create a SQL statement
	Statement sectstmt = con.createStatement();
	//Make a SELECT query
	String sectquery = "SELECT * FROM sections WHERE cid=" + request.getParameter("courseid");
	
	//Run the query against the database.
	ResultSet secttable = sectstmt.executeQuery(sectquery);
	
	out.print("<div>");
	out.print("<div>");
	
	out.print("<h4>Sections:</h4>");

	//Make an HTML table to show the results in:
	out.print("<table>");

	//make a row
	out.print("<tr>");
	//make a column
	out.print("<td class="  + '"' + "thead" + '"' + '>');
	//print out column header
	out.print("section #");
	out.print("</td>");
	//make a column
	out.print("<td class="  + '"' + "thead" + '"' + '>');
	out.print("time of week");
	out.print("</td>");
	//make a column
	out.print("<td class="  + '"' + "thead" + '"' + '>');
	out.print("professor");
	out.print("</td>");
	out.print("</tr>");

	//parse out the results
	while (secttable.next()) {
//make a row
out.print("<tr>");
//make a column
out.print("<td>");
//Print out current username:
out.print(secttable.getString("section"));
out.print("</td>");
out.print("<td>");
//Print out current password:
Statement schedstmt = con.createStatement();
String schedquery = "select S.cid, S.section, M.mday, M.timefrom, M.timeto from sections S, meets M where S.section=M.section AND S.section=" 
	+ secttable.getString("section") + " AND S.cid=" 
	+ request.getParameter("courseid");
ResultSet schedtable = schedstmt.executeQuery(schedquery);
String sched = "";
if (schedtable.next()) {
	sched = schedtable.getString("M.mday") + " from " + schedtable.getString("M.timefrom") 
		+ " to " + schedtable.getString("M.timeto");
}
out.print(sched);
out.print("</td>");
out.print("<td>");
//Print out current user id\
Statement profstmt = con.createStatement();
String profquery = "select pname from (select pid, pname from profs) as X where pid=" + secttable.getString("pid");
ResultSet proftable = profstmt.executeQuery(profquery);
String prof = "";
if (proftable.next()) {
	prof = proftable.getString("pname");
}
out.print(prof);
out.print("</td>");
out.print("</tr>");
	}
	out.print("</table>");
	out.print("</div>");
	
%>
	<br>
		<form method="post" action="addSection.jsp">
			<input type="hidden" value="<%= request.getParameter("courseid") %>" name="cid" />
			<input type="submit" value="Add Section" />
		</form>
	<br>
	<%
	
	out.print("</div>");

	//close the connection.
	con.close();

} catch (Exception e) {
} %>
<a href='admin.jsp'>Back to home</a>
<a href='logout.jsp'>Logout</a>
</body>
</html>