<%-- 
    Document   : search
    Created on : Jul 9, 2017, 10:57:14 AM
    Author     : Admin
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Cloud Drive</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/sb-admin.css" rel="stylesheet">

    <!-- Morris Charts CSS -->
    <link href="css/plugins/morris.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

  <%session.setAttribute("Active","Dashboard"); %>
</head>

<body>

    <div id="wrapper">

        <jsp:include page="navbar.jsp"/>

        <div id="page-wrapper">

            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            <small>Users</small>
                        </h1>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-lg-12 col-md-6">
                        <div class="row">
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
      ResultSet rs=stmt.executeQuery("select distinct (case when n.recUser is not null and n.fromUser='"+session.getAttribute("UserID")+"' and n.fileid='' then 'Already Sent' else 'Add Friend' end) as nstat,username,userid from Users u left join Notifications n on u.userid=n.recUser and n.fileid='' where username like '%"+request.getParameter("query")+"%' and userid!='"+session.getAttribute("UserID")+"'");
      while(rs.next())
      {
          %>
          
                    <div class="col-lg-6 col-md-6">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-9">
                                        <div class="huge"><i class="glyphicon glyphicon-user"></i>  <%= rs.getString("username")%></div>
                                    </div>
                                    <div class="col-xs-3 text-right">
                                        <form action="<%if(!rs.getString("nstat").equals("Already Sent"))
                                                    out.println("dbAddNoti.jsp");
                                                else
                                            out.println("");
                                        %>" method="POST">
                                    <input type="hidden" name="recid" value="<%=rs.getString("userid")%>" />
                                    <input type="hidden" name="req" value="<%out.println("friendRequest");%>" />
                                    <input type="hidden" name="fileid" value="<%out.println("");%>" />
                                    <input type="hidden" name="query" value="<%=request.getParameter("query")%>" />
                                    <input class="pull-right btn btn-primary" type="submit" value="<%=rs.getString("nstat")%>" />
                                        </form>
                                    </div>
                                </div>
                            </div>
                           
                        </div>
                    </div>
       
          <%
      }
          %>
             </div>
                    </div>
                </div>
                <!-- /.row -->

                
                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            <small>Files</small>
                        </h1>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-lg-12 col-md-6">
                        <div class="row">
                        <%
        	try {
        		// Establish the connection.
        		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                    //DriverManager.registerDriver(new sun.jdbc.odbc.JdbcOdbcDriver());
            		con = DriverManager.getConnection(connectionUrl);
                }catch(Exception e)
                {}
   Statement stmt2 = null;
                                 //STEP 4: Execute a query
      stmt2 = con.createStatement();
      ResultSet rs2=stmt2.executeQuery("select distinct (case when n.recUser is not null and n.fromUser='"+session.getAttribute("UserID")+"' and f.fileid=n.fileid and n.status in (0,2) then 'Already Requested' when n.recUser is not null and n.fromUser='"+session.getAttribute("UserID")+"' and f.fileid=n.fileid and n.status=1 then 'You Owned' else 'Request File' end) as fstat,(case when extension='Folder' then 'glyphicon-folder-open' else 'glyphicon-file' end) as extension,displayname,u.userid,u.username,f.fileid from Files f inner join Users u on f.owner=u.userid left join Notifications n on f.owner=n.recUser and n.fileid=f.fileid where filename like '%"+request.getParameter("query")+"%' and alerts!='Private' and u.userid<>'"+session.getAttribute("UserID")+"'");
      while(rs2.next())
      {
          %>
          
                    <div class="col-lg-6 col-md-6">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-8">
                                        <div class="huge"><i class="glyphicon <%= rs2.getString("extension")%>"></i>   <%= rs2.getString("displayname")%></div>
                                    </div>
                                    <div class="col-xs-4 text-right">
                                        <div>Owned by - <%=rs2.getString("username")%></div>
                                    </div>
                                </div>
                            </div>
                                        <div class="panel-footer">
                                    <a href="fileDetails.jsp?fileid=<%=rs2.getString("fileid")%>&user=other">
                                <div>
                                    <span class="pull-left">View Details</span>
                                </div>
                            </a>
                                <form action="<%if(rs2.getString("fstat").equals("Request File"))
                                                    out.println("dbAddNoti.jsp");
                                                else
                                            out.println("");
                                        %>" method="POST">
                                    <input type="hidden" name="recid" value="<%=rs2.getString("userid")%>" />
                                    <input type="hidden" name="fileid" value="<%=rs2.getString("fileid")%>" />
                                    <input type="hidden" name="req" value="<%out.println("fileRequest");%>" />
                                    <input type="hidden" name="query" value="<%=request.getParameter("query")%>" />
                                    <input class="pull-right btn btn-primary" type="submit" value="<%=rs2.getString("fstat")%>" />
                                </form>
                                    <div class="clearfix"></div>
                                        </div>
                        </div>
                    </div>
       
          <%
      }
          %>
             </div>
                    </div>
                </div>
            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Morris Charts JavaScript -->
    <script src="js/plugins/morris/raphael.min.js"></script>
    <script src="js/plugins/morris/morris.min.js"></script>
    <script src="js/plugins/morris/morris-data.js"></script>

</body>

</html>
