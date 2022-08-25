<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title><%=session.getAttribute("user")%> Course List</title>
</head>
<body>
<header><h1>Course registration info for <%=session.getAttribute("user")%>:</h1></header>
<br><br>
Note: a missing grade means your professor has not assigned your grade yet.
<br><br>
<table>
       <tr><td># | </td><td>Course ID | </td><td>Course Name | </td><td>Credits | </td><td>Department | </td><td>Grade</td></tr>
       <%
       Class.forName("com.mysql.jdbc.Driver");
       db studentdb = new db();
       Connection con = studentdb.getConnection();
       Statement st = con.createStatement();
       ResultSet rs;
       rs = st.executeQuery("SELECT e.cid, c.cname, c.credits, c.department, e.grade FROM enrollment e JOIN courses c ON e.cid = c.cid WHERE sid = " + session.getAttribute("sid"));
       int entry = 0;
       while(rs.next()){
    	   entry++;
    	   if (rs.getString(5) != null){
    		   out.println("<tr><td>"+entry+"</td><td>"+rs.getInt(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getInt(3)+"</td><td>"+rs.getString(4)+"</td><td>"+rs.getString(5)+"</td></tr>");
    	   }
    	   else out.println("<tr><td>"+entry+"</td><td>"+rs.getInt(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getInt(3)+"</td><td>"+rs.getString(4)+"</td><td>-</td></tr>");
       }
       con.close();
       %>
</table>
<br><br>
<form method="get" action="student.jsp">
<input type="submit" value="Go Back">
</form>
</body>
</html>