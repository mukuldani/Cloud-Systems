<%@page import="java.sql.*"%>
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
                
String recid="";
recid=request.getParameter("recid").trim();
String req="";
req=request.getParameter("req").trim();
String query="";
query=request.getParameter("query");
String fileid="";
fileid=request.getParameter("fileid").trim();

String fromuser="";
fromuser=session.getAttribute("UserID").toString();

PreparedStatement ps=con.prepareStatement("insert into Notifications(type,fromUser,recUser,fileid,ontime,status) values ('"+req+"','"+fromuser+"','"+recid+"','"+fileid+"',getdate(),0)");
int i=ps.executeUpdate();

if(i==1)
{
    %>
    <jsp:forward page="search.jsp?query=<%=query%>"></jsp:forward>
<%
}
%>