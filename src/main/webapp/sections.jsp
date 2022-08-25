<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sections for course with id = <%=request.getParameter("command")%></title>
</head>
<body>
<%
  String chosenCid = request.getParameter("command")+""; 
  if (chosenCid.equals("null")) response.sendRedirect("register.jsp");
  else session.setAttribute("cid", chosenCid);
  out.println("<header><h1>Choose a section to register into:</h1></header><br>");
  out.println("Note: Only the sections that can fit into your schedule will be displayed below.");
  out.println("Note 2: Time is displayed using 24hr format.");
%>
<br><br>
<form method="post" action="rDone.jsp">
		  <%
		    Class.forName("com.mysql.jdbc.Driver");
		    db studentdb = new db();
		    Connection con = studentdb.getConnection();
	        Statement st = con.createStatement();
	        ResultSet rs;
	        String sid = session.getAttribute("sid")+"";
	        rs = st.executeQuery("select s.section, m.mday, m.timefrom, m.timeto from sections s, meets m where s.section = m.section and s.cid = m.cid and s.cid ="+chosenCid);
	        while(rs.next()){
	        	int section = rs.getInt(1);
	        	out.println("<input type=\"radio\" name=\"command\" value=\""+section+"\"/> Section "+section+" meets on "+rs.getString(2)+" from "+rs.getTime(3)+" to "+rs.getTime(4));
	        	out.println("<br>");
	        }
		  %>
		  <br>
		  <input type="submit" value="Choose Section"/>
		</form>
<br><br>
<form method="get" action="register.jsp">
<input type="submit" value="Go Back">
</form>
</body>
</html>