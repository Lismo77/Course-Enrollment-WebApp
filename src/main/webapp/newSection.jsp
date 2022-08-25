<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>New section</title>
</head>
<body>
<a href='logout.jsp'>Logout</a>
<br>
	<%
	

		try {

		//Get the database connection
		db sectdb = new db();	
		Connection con = sectdb.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the index.jsp
		int newSectid = Integer.parseInt(request.getParameter("sectid"));
		int newCid = Integer.parseInt(request.getParameter("cid"));
		int newPid = Integer.parseInt(request.getParameter("pid"));
		String newMday = request.getParameter("meetday");
		String newTimefrom = request.getParameter("timefrom");
		String newTimeto = request.getParameter("timeto");

		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO sections(section, cid, pid)"
		+ "VALUES (?,?,?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setInt(1, newSectid);
		ps.setInt(2, newCid);
		ps.setInt(3, newPid);
		ps.executeUpdate();
		
		insert = "INSERT INTO meets(section, cid, mday, timefrom, timeto)"
			+ "VALUES (?,?,?,?,?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		ps = con.prepareStatement(insert);
		
		ps.setInt(1, newSectid);
		ps.setInt(2, newCid);
		ps.setString(3, newMday);
		ps.setString(4, newTimefrom);
		ps.setString(5, newTimeto);
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