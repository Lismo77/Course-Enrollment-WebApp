<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title><%=session.getAttribute("user")%> Course Registration</title>
</head>
<body>
<header><h1>List of available courses you are eligible to take based on prerequisites:</h1></header>
<br><br>
<form method="post" action="sections.jsp">
		  <%
		    String username = ""+session.getAttribute("user");
		    Class.forName("com.mysql.jdbc.Driver");
		    db studentdb = new db();
		    Connection con = studentdb.getConnection();
	        Statement st = con.createStatement();
	        ResultSet rs;
	        String sid = session.getAttribute("sid")+"";
	        rs = st.executeQuery("select cid, cname from courses where cid not in(select cid from prereqs where prid not in(select cid from enrollment where sid = "+sid+")) and (cid not in(select cid from enrollment where sid = "+sid+") or cid in(select cid from enrollment where sid = "+sid+" and (grade = 'D' or grade = 'F'))) and cid not in(select cid from prereqs where prid in(select cid from enrollment where sid = "+sid+" and (grade = 'D' or grade = 'F')))");
	        while(rs.next()){
	        	int cid = rs.getInt(1);
	        	out.println("<input type=\"radio\" name=\"command\" value=\""+cid+"\"/>"+ rs.getString(2));
	        	out.println("<br>");
	        }
		  %>
		  <br>
		  <input type="submit" value="Choose Course"/>
		</form>
<br><br>
<form method="get" action="student.jsp">
<input type="submit" value="Go Back">
</form>
</body>
</html>
