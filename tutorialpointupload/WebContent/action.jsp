
<%@page import="java.sql.*"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<% 
	
try{
     Class.forName("com.mysql.jdbc.Driver");
     Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "root");
   
     String insertQuery="Insert into uploaddownload(filename) values (?)";
     
     String filename=request.getParameter("file");
     
     PreparedStatement pstmt =conn.prepareStatement(insertQuery);
     pstmt.setString(1,filename);
     Statement stmt = conn.createStatement();
     int insert=0;
     insert=pstmt.executeUpdate();
     ResultSet rs = stmt.executeQuery("select * from uploaddownload");
   
     
  
     
     if(insert==0)
     {
           out.println("Error while insert the record");
     }else
           
     {
           response.sendRedirect("fileUpload1.jsp");
     }
     
}catch(Exception e)
{
     out.println(e.getMessage());
}
%>

</body>
</html>