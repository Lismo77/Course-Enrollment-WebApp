<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title></title>
</head>
<body>
<%
  String cid = session.getAttribute("cid")+"";
  String sid = session.getAttribute("sid")+"";
  String section = request.getParameter("command");
  Class.forName("com.mysql.jdbc.Driver");
  db studentdb = new db();
  Connection con = studentdb.getConnection();
  Statement st = con.createStatement();
  ResultSet rs;
  rs = st.executeQuery("select m.mday, m.timefrom, m.timeto from meets m where m.cid ="+cid+" and m.section ="+section);
  rs.next();
  String day = rs.getString(1);
  String fromA[] = (rs.getTime(2)+"").split("");
  String toA[] = (rs.getTime(3)+"").split("");
  String fromB = fromA[0]+fromA[1]+"."+fromA[3]+fromA[4];
  String toB = toA[0]+toA[1]+"."+toA[3]+toA[4];
  float from = Float.parseFloat(fromB);
  float to = Float.parseFloat(toB);
  rs = st.executeQuery("select m.mday, m.timefrom, m.timeto from enrollment e, meets m where e.cid = m.cid and e.section = m.section and e.sid = "+sid+" and e.grade is NULL;");
  boolean fit = true;
  while(rs.next()){
	  String cday = rs.getString(1);
	  String cfromA[] = (rs.getTime(2)+"").split("");
	  String ctoA[] = (rs.getTime(3)+"").split("");
	  String cfromB = cfromA[0]+cfromA[1]+"."+cfromA[3]+cfromA[4];
	  String ctoB = ctoA[0]+ctoA[1]+"."+ctoA[3]+ctoA[4];
	  float cfrom = Float.parseFloat(cfromB);
	  float cto = Float.parseFloat(ctoB);
	  if(cday.equals(day)){
		  if(from >= cfrom && from <= cto){
			  out.println("This section cannot fit into your schedule. <a href='register.jsp'>Choose another section.</a>");
			  fit = false;
			  break;
		  }else if(to >= cfrom && to <= cto){
			  out.println("This section cannot fit into your schedule. <a href='register.jsp'>Choose another section.</a>");
			  fit = false;
			  break;
		  }else if(from < cfrom && to > cto){
			  out.println("This section cannot fit into your schedule. <a href='register.jsp'>Choose another section.</a>");
			  fit = false;
			  break;
		  }
	  }
  }if(fit){
      rs = st.executeQuery("select * from enrollment where sid="+sid+" and cid="+cid);
      if (rs.next()){
          st.executeUpdate("update enrollment set section ="+section+",grade = null where sid="+sid+" and cid="+cid);
      }else st.executeUpdate("INSERT INTO enrollment VALUES ("+sid+","+cid+","+section+",null)");
      out.println("Registration in course with id "+cid+ "successful! <a href='student.jsp'>Return to dashboard.</a>");
  }
%>
</body>
</html>