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
                
String planid="";
planid=request.getParameter("planid");

String userid="";
userid=session.getAttribute("UserID").toString();

PreparedStatement ps=con.prepareStatement("insert into Subscription(userid,planid,ontime,status) values ('"+userid+"','"+planid+"',getdate(),0)");
int i=ps.executeUpdate();

if(i==1)
{
    %>
    <script>
function goBack() {
    //window.history.back();
    location.replace(document.referrer);
}
goBack();
</script>
<%
}
%>