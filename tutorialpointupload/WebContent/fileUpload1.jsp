<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.io.output.*"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>

<%
	File file;
	int maxFileSize = 5000 * 1024;
	int maxMemSize = 5000 * 1024;
	String filePath = "D:\\apache-tomcat-8.0.9\\apache-tomcat-8.0.9\\webapps\\data\\";

	String contentType = request.getContentType();
	if ((contentType.indexOf("multipart/form-data") >= 0)) {

		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(maxMemSize);
		factory.setRepository(new File("c:\\temp"));
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(maxFileSize);
		try {
			 Class.forName("com.mysql.jdbc.Driver");
		        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "root");
		        Statement stmt = conn.createStatement();
		        ResultSet rs = stmt.executeQuery("select filename from uploaddownload");
		       
			List fileItems = upload.parseRequest(request);
			Iterator i = fileItems.iterator();
			out.println("<html>");
			out.println("<body>");
			
			while (i.hasNext()) {
				FileItem fi = (FileItem) i.next();
				if (!fi.isFormField()) {
					String fieldName = fi.getFieldName();
					String fileName = fi.getName();
					boolean isInMemory = fi.isInMemory();
					long sizeInBytes = fi.getSize();
					
					file = new File(filePath + rs.getString(1));
					fi.write(file);
					out.println("Uploaded Filename: " + filePath + fileName + "<br>");
				}
			}
			out.println("</body>");
			out.println("</html>");
		} catch (Exception ex) {
			System.out.println(ex);
		}
	} else {
		out.println("<html>");
		out.println("<body>");
		out.println("<p>No file uploaded</p>");
		out.println("</body>");
		out.println("</html>");
	}
%>