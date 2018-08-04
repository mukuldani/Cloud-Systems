<%-- 
    Document   : dbAddFolder
    Created on : Jul 9, 2017, 3:46:05 PM
    Author     : Admin
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
 String connectionUrl = "jdbc:sqlserver://localhost:1433;" +
			"databaseName=CloudSystems;user=sa;password=Bvimit@123;";
                

		// Declare the JDBC objects.
		Connection con = null;
		
        	try {
        		// Establish the connection.
        		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                    //DriverManager.registerDriver(new sun.jdbc.odbc.JdbcOdbcDriver());
            		con = DriverManager.getConnection(connectionUrl);
                }catch(Exception e)
                {}   
   Statement stmt = null;
  
      //STEP 4: Execute a query
      stmt = con.createStatement();
      int lastNo=0;
      ResultSet rs=stmt.executeQuery("select (case when max(seq) is null then 0 else max(seq) end) from files");
      if(rs.next())
      {
           lastNo=Integer.parseInt(rs.getString(1));
      }
      
      
      
      
      PreparedStatement statement = con.prepareStatement("insert into files (fileid,filename,owner,displayname,protection,password,extension,ontime,status,seq,parentid) values('F"+(lastNo+1)+"',?,?,?,?,?,'folder',getdate(),0,"+(lastNo+1)+",?);");
      statement.setString(1, request.getParameter("txtFolderName"));
      statement.setString(2, (String)session.getAttribute("UserID"));
      statement.setString(3, request.getParameter("txtFolderName"));
      statement.setString(4, request.getParameter("txtEncryption"));
      statement.setString(5, request.getParameter("txtPassword"));
      statement.setString(6, request.getParameter("txtParent").trim());
        int result=statement.executeUpdate();
        if(result==1)
        {
             if(request.getParameter("txtParent")!=null&&!request.getParameter("txtParent").isEmpty()&&!request.getParameter("txtParent").equals(""))
             {
                 String parent=request.getParameter("txtParent");
                 %>
                 
                 <jsp:forward page='fileStructure.jsp'>
                     <jsp:param name="parentid" value='<%=parent%>'/>
                 </jsp:forward>
                     
<%
             }
             else
             {
                 %>

                 <jsp:forward page="fileStructure.jsp"></jsp:forward>
<%
             }
        }
%>