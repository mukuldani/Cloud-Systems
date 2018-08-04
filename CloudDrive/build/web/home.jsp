<%@page import="java.sql.*"%>
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
    <link href="css/business-frontpage.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <script src="js/popper/popper.min.js"></script>
    <script src="js/jquery.min.js"></script>
      <link rel="stylesheet" href="css/style.css">

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

        <div id="page-wrapper" style="margin-top: -55px;">

            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Dashboard <small>Statistics Overview</small>
                        </h1>
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-dashboard"></i> Dashboard
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

                <div class="row">
                    <div class="col-lg-12">
                        <div class="alert alert-info alert-dismissable">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                            <i class="fa fa-info-circle"></i>  <strong>Subscribe</strong> New Plans to Increase Storage
                        </div>
                    </div>
                </div>
                <!-- /.row -->

                
                
                
                <div class="row">
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-comments fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div>Check Your New Messages</div>
                                    </div>
                                </div>
                            </div>
                            <a href="sendSMS.jsp">
                                <div class="panel-footer">
                                    <span class="pull-left">View Details</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-green">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-tasks fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge"><%
                                        
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
                Statement st=con.createStatement();
                ResultSet rs=st.executeQuery("select count(*) from Files where owner='"+session.getAttribute("UserID")+"'");
                while(rs.next())
                {
                    out.println(rs.getString(1));
                }
                                        %></div>
                                        <div>Files were Uploaded</div>
                                    </div>
                                </div>
                            </div>
                            <a href="fileStructure.jsp">
                                <div class="panel-footer">
                                    <span class="pull-left">View Details</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-yellow">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-file-archive-o fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge"><%
                ResultSet rs2=st.executeQuery("select count(*) from FileTrack where recid='"+session.getAttribute("UserID")+"'");
                while(rs2.next())
                {
                    out.println(rs2.getString(1));
                }
                                        %></div>
                                        <div>Files were shared with you!</div>
                                    </div>
                                </div>
                            </div>
                            <a href="sharedWithMe.jsp">
                                <div class="panel-footer">
                                    <span class="pull-left">View Details</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-red">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-male fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge"><%
                ResultSet rs3=st.executeQuery("select count(*) from Notifications where status=1 and (recUser='"+session.getAttribute("UserID")+"' or fromUser='"+session.getAttribute("UserID")+"')");
                while(rs3.next())
                {
                    out.println(rs3.getString(1));
                }
                                        %></div>
                                        <div>New Friends!</div>
                                    </div>
                                </div>
                            </div>
                          
                                        <div class="panel-footer" style="height: 40px;">
                                    <div class="clearfix"></div>
                                </div>
                         
                        </div>
                    </div>
                </div>
                <!-- /.row -->

                
                <div class="container" style="height: 50vh;">
                 <div class="row">
            <div class="col-sm-4 my-4">
                <div class="card">
                    <div class='package'>
                        <form action="dbAddSubscription.jsp" method="POST">
                            <input type="hidden" name="planid" value="1" />
                            
                        <div class='name'>Limited</div>
                        <div class='price'>&#8377; 500 for 15 GB</div>
                        <div class='trial'>Till Full Disk Usage</div>
                        <hr class="hrr">
                        <ul class="ull">
                          <li class="lii">
                            <strong>15</strong>
                            GB of Storage Space
                          </li>
                          <li class="lii">
                            Chat box
                          </li>
                          <li class="lii">
                            <strong>File</strong>
                            Sharing with 2 way Checking
                          </li>
                        </ul>
                            <div style="position: absolute; bottom: 10px;left:0;width: 100%;padding: 10px;">
    <input type="submit" class="btn btn-block btn-info" value="Subscribe" />
    </div>
                        </form>
                      </div>
                </div>
            </div>
            <div class="col-sm-4 my-4">
                <div class="card">
                    <div class='package brilliant'>
                        <form action="dbAddSubscription.jsp" method="POST">
                            <input type="hidden" name="planid" value="2" />
    <div class='name'>Brilliant</div>
    <div class='price'>&#8377; 750 for 30 GB</div>
    <div class='trial'>Till Full Disk Usage</div>
    <hr class="hrr">
                        <ul class="ull">
      <li class="lii">
                            <strong>30</strong>
                            GB of Storage Space
                          </li>
                          <li class="lii">
                            Chat box
                          </li>
                          <li class="lii">
                            <strong>File</strong>
                            Sharing with 2 way Checking
                          </li>
    </ul>
        <div style="position: absolute; bottom: 10px;left:0;width: 100%;padding: 10px;">
    <input type="submit" class="btn btn-block btn-info" value="Subscribe" />
    </div>
                        </form>
  </div>
                </div>
            </div>
            <div class="col-sm-4 my-4">
                <div class="card">
                    
                    <div class='package'>
                        <form action="dbAddSubscription.jsp" method="POST">
                            <input type="hidden" name="planid" value="3" />
    <div class='name'>Basic</div>
    <div class='price'>FREE</div>
    <div class='trial'>Available for a Month</div>
    <hr class="hrr">
                        <ul class="ull">
      <li class="lii">
                            <strong>15</strong>
                            GB of Storage Space
                          </li>
                          <li class="lii">
                            Chat box
                          </li>
                          <li class="lii">
                            <strong>File</strong>
                            Sharing with 2 way Checking
                          </li>
    </ul>
    <div style="position: absolute; bottom: 10px;left:0;width: 100%;padding: 10px;">
    <input type="submit" class="btn btn-block btn-info" value="Subscribe" />
    </div>
                        </form>
  </div>
                    
                </div>
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
