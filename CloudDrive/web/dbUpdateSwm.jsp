<%@page import="java.sql.*"%>
<%
    String connectionUrl = "jdbc:sqlserver://localhost:1433;" +
			"databaseName=CloudSystems;user=sa;password=Bvimit@123;";
                

String txtFile="";
String txtPassword="";
String txtKey="";
String key="",pass="";
		// Declare the JDBC objects.
		Connection con = null;
		
        	try {
        		// Establish the connection.
        		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                    //DriverManager.registerDriver(new sun.jdbc.odbc.JdbcOdbcDriver());
            		con = DriverManager.getConnection(connectionUrl);
               
                
txtFile=request.getParameter("txtFile").trim();
txtPassword=request.getParameter("txtPassword").trim();
txtKey=request.getParameter("txtKey");


Statement st=con.createStatement();
ResultSet rs=st.executeQuery("select * from FileTrack where fileid='"+txtFile+"' and recid='"+session.getAttribute("UserID") +"'");
while(rs.next())
{
    key=rs.getString("encrykey");
    pass=rs.getString("pass");
}
out.println("key="+key+"pass="+pass);

if(key.trim().equals(txtKey.trim())&&pass.trim().equals(txtPassword.trim()))
{
  
PreparedStatement ps=con.prepareStatement("update FileTrack set status=1 where fileid='"+txtFile+"' and recid='"+session.getAttribute("UserID") +"'");
//out.println("update FileTrack set status=1 where fileid='"+txtFile+"' and recid='"+session.getAttribute("UserID") +"'");
int i=ps.executeUpdate();
  
if(i>=1)
{
    %>
    <jsp:forward page="sharedWithMe.jsp"></jsp:forward>
<%
}else
{
     %>
    <jsp:forward page="sharedWithMe.jsp"></jsp:forward>
<%
}
}else
{
     %>
    <jsp:forward page="sharedWithMe.jsp"></jsp:forward>
<%
}
 }catch(Exception e)
                {
                    out.println(e+"key="+key+"pass="+pass+"<br>select * from FileTrack where fileid='"+txtFile+"' and recid='"+session.getAttribute("UserID") +"'");
                }
%>