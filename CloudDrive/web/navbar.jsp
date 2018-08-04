<%-- 
    Document   : navbar
    Created on : Jul 3, 2017, 10:09:13 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
  <%@page import="java.sql.*"%>
<%
    String connectionUrl = "jdbc:sqlserver://localhost:1433;" +
			"databaseName=CloudSystems;user=sa;password=Bvimit@123;";
                

		// Declare the JDBC objects.
		Connection con = null;
		
        	try {
        		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            		con = DriverManager.getConnection(connectionUrl);
                }catch(Exception e)
                {}
                
                String planid="";
                planid=request.getParameter("planid");

                String userid="";
                userid=session.getAttribute("UserID").toString();
%>
      
<!DOCTYPE html>
<!-- Navigation -->
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="home.jsp">Cloud Drive</a>
            </div>
            <!-- Top Menu Items -->
            <ul class="nav navbar-right top-nav">
                
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-envelope"></i> <b class="caret"></b></a>
                    <ul class="dropdown-menu message-dropdown">
                        
                        
                        <%
                        Statement stMessage=con.createStatement();
                        ResultSet rsMsg=stMessage.executeQuery("select t.sender,u.username,t.receiver,t.message,cast(c.MaxVal as varchar(50)) as MaxVal from ( select max(msid) as maxms,sender,receiver,max(ontime) as MaxVal from Messages group by sender,receiver) c inner join Messages t on t.msid=c.maxms and t.ontime = c.MaxVal inner join Users u on t.sender=u.userid where t.receiver='"+session.getAttribute("UserID")+"' order by t.sender,t.receiver");
                        while(rsMsg.next())
                        {
                        %>
                        <li class="message-preview">
                            <a href="sendSMS.jsp?id=<%=rsMsg.getString("sender")%>">
                                <div class="media">
                                    <span class="pull-left">
                                        <img class="media-object" src="img/person.png" width="30" height="30" alt="">
                                    </span>
                                    <div class="media-body">
                                        <h5 class="media-heading"><strong><%=rsMsg.getString("username")%></strong>
                                        </h5>
                                        <p class="small text-muted"><i class="fa fa-clock-o"></i> <%=rsMsg.getString("MaxVal")%></p>
                                        <p><%=rsMsg.getString("message")%></p>
                                    </div>
                                </div>
                            </a>
                        </li>
                        <%}%>
                        <li class="message-footer">
                            <a href="sendSMS.jsp">Read All New Messages</a>
                        </li>
                    </ul>
                </li>
                <li class="dropdown" >
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-bell"></i> <b class="caret"></b></a>
                    <ul class="dropdown-menu alert-dropdown" style="width:300px;">
                     
                        
                                     

<%
Statement stUser=con.createStatement();
ResultSet rsUser=stUser.executeQuery("select notid,type,username,recUser,n.ontime from Notifications n inner join Users u on u.userid=fromUser where recUser='"+session.getAttribute("UserID")+"' and fileid='' and type='friendRequest' and n.status=0");

while(rsUser.next())
{
    %>
                        <li>
                            <div class="well"><%=rsUser.getString("username")%> Wants to be Friend
                            <!--input type='submit' class="btn btn-primary" value="Give Access"/-->
                            <a href='dbnoti.jsp?notid=<%=rsUser.getString("notid")%>&s=1' class="btn btn-primary">Accept Request</a>
                            <!--input type='submit' class="btn btn-primary" value="Reject Request"/-->
                            <a href='dbnoti.jsp?notid=<%=rsUser.getString("notid")%>&s=2' class="btn btn-primary">Reject Request</a>
                            </div>
                        </li>
                        <%
}

ResultSet rsUser2=stUser.executeQuery("select notid,type,username,recUser,cast(n.ontime as varchar(50)) as ontime,n.status from Notifications n inner join Users u on u.userid=fromUser where recUser='"+session.getAttribute("UserID")+"' and fileid='' and type='friendRequest' and n.status!=0");
while(rsUser2.next())
{
    %>
                        <li>
                            <div class="well" style="margin:5px;font-size: 12px;">You <%
                    if(rsUser2.getString("status").equals("1")) {
                out.println("Become a Friends "); }
            else {
                out.println("Rejected the Request to Become a Friends ");}%> with <%=rsUser2.getString("username")%> 
                       <span class="pull-right" style="font-size: 10px;"><%=rsUser2.getString("ontime")%></span>
                            </div>
                        </li>
                        <%
}
%>

                        
                        <%
                Statement st=con.createStatement();
                ResultSet rs=st.executeQuery("select notid,type,username,recUser,displayname,n.ontime from Notifications n inner join Files f on f.fileid=n.fileid inner join Users u on u.userid=fromUser where recUser='"+session.getAttribute("UserID")+"' and n.status=0");
                
                while(rs.next())
                {
                    %>
                        <li>
                            <div class="well"><%=rs.getString("username")%> requested for file <%=rs.getString("displayname")%>
                            <!--input type='submit' class="btn btn-primary" value="Give Access"/-->
                            <a href='dbnoti.jsp?notid=<%=rs.getString("notid")%>&s=1' class="btn btn-primary">Give Access</a>
                            <!--input type='submit' class="btn btn-primary" value="Reject Request"/-->
                            <a href='dbnoti.jsp?notid=<%=rs.getString("notid")%>&s=2' class="btn btn-primary">Reject Request</a>
                            </div>
                        </li>
                        <%
                }
                
                ResultSet rs2=st.executeQuery("select notid,type,username,recUser,displayname,cast(n.ontime as varchar(50)) as ontime,n.status from Notifications n inner join Files f on f.fileid=n.fileid inner join Users u on u.userid=fromUser where recUser='"+session.getAttribute("UserID")+"' and n.status!=0");
                
                while(rs2.next())
                {
                    %>
                        <li>
                            <div class="well" style="margin:5px;font-size: 12px;">You <%
                    if(rs2.getString("status").equals("1")) {
                out.println("Shared"); }
            else {
                out.println("Rejected");}%> <%=rs2.getString("displayname")%> with <%=rs2.getString("username")%> 
                <span class="pull-right" style="font-size: 10px;"><%=rs2.getString("ontime")%></span>
                            </div>
                        </li>
                        <%
                }
%>
                        
                        <li class="divider"></li>
                        <li>
                            <a href="#">View All</a>
                        </li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <%   
  if(session.getAttribute("Username")!=null)
  {
String name=(String)session.getAttribute("Username");  
out.print(""+name);  
  }
  else
  {
      %><jsp:forward page="index.php#download"/><%
  }
  
%> <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="profile.jsp"><i class="fa fa-fw fa-user"></i> Profile</a>
                        </li>
                        <li>
                            <a href="sendSMS.jsp"><i class="fa fa-fw fa-envelope"></i> Inbox</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="index.jsp"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                        </li>
                    </ul>
                </li>
            </ul>
            <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
            <div class="collapse navbar-collapse navbar-ex1-collapse">
                <ul class="nav navbar-nav side-nav">
                    <li class="sidebar-search" style="padding: 10px;">
                        <form action="search.jsp">
                        <div class="input-group custom-search-form">
                            <input type="text" name='query' class="form-control" placeholder="Search...">
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="submit">
                                <i class="fa fa-search"></i>
                            </button>
                        </span>
                        </div>
                        </form>
                        <!-- /input-group -->
                    </li>
                    
                    <li class="<%if(session.getAttribute("Active").toString().equals("Dashboard")) out.println("active");%>">
                        <a href="home.jsp"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a>
                    </li>
                    <li class="<%if(session.getAttribute("Active").toString().equals("DiskStatus")) out.println("active");%>">
                        <a href="diskStatus.jsp"><i class="fa fa-fw fa-bar-chart-o"></i> Disk Status</a>
                    </li>
                    <li class="<%if(session.getAttribute("Active").toString().equals("sendSMS")) out.println("active");%>">
                        <a href="sendSMS.jsp"><i class="fa fa-fw fa-edit"></i> Chats</a>
                    </li>
                    <li class="<%if(session.getAttribute("Active").toString().equals("SharedWithMe")) out.println("active");%>">
                        <a href="sharedWithMe.jsp"><i class="fa fa-fw fa-wrench"></i> Shared With Me</a>
                    </li>
                    <li class="<%if(session.getAttribute("Active").toString().equals("File")) out.println("active");%>">
                        <a href="javascript:;" data-toggle="collapse" data-target="#demo"><i class="fa fa-fw fa-file"></i> File <i class="fa fa-fw fa-caret-down"></i></a>
                        <ul id="demo" class="collapse">
                            <li>
                                <a href="file.jsp">Add File</a>
                            </li>
                            <li>
                                <a href="fileStructure.jsp">Files</a>
                            </li>
                        </ul>
                    </li>
                   
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </nav>
