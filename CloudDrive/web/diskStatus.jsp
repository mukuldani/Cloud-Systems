<%-- 
    Document   : diskStatus
    Created on : Jul 10, 2017, 7:14:38 AM
    Author     : Admin
--%>

<%@page import="java.text.DecimalFormat"%>
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

  <%session.setAttribute("Active","DiskStatus"); %>
  
    <!-- jQuery -->
    <script src="js/jquery.js"></script>
    <script src="js/jquery.min.js"></script>
    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>
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
 
      
          %>
    
  <script>
 $(function() {

    var data = [
    <%
               Statement stmt = null;
                                 //STEP 4: Execute a query
      stmt = con.createStatement();
      //ResultSet rs=stmt.executeQuery("select extension,sum(cast(size as int)) as count from Files where extension!='folder' and owner='"+session.getAttribute("UserID")+"' group by extension union select 'Still Free' as extension,16106127360-sum(cast(size as int)) from Files where owner='"+session.getAttribute("UserID")+"'");
      ResultSet rs=stmt.executeQuery("select extension,sum(cast(size as int)) as count from Files where extension!='folder' and owner='"+session.getAttribute("UserID")+"' group by extension union select 'Still Free' as extension,402653184-sum(cast(size as int)) from Files where owner='"+session.getAttribute("UserID")+"'");
        
                while(rs.next())
      {
          out.print("{label : ' "+rs.getString("extension")+"',");
          out.print("data : "+rs.getString("count")+"},");
      }%>
        ];

    var plotObj = $.plot($("#flot-pie-chart"), data, {
        series: {
            pie: {
                show: true
            }
        },
        grid: {
            hoverable: true
        },
        tooltip: true,
        tooltipOpts: {
            content: "%p.0%, %s", // show percentages, rounding to 2 decimal places
            shifts: {
                x: 20,
                y: 0
            },
            defaultTheme: false
        }
    });

});
$(function() {
    // Donut Chart
    Morris.Donut({
        element: 'morris-donut-chart',
        data: [<%
               Statement stmt2 = null;
                                 //STEP 4: Execute a query
      stmt2 = con.createStatement();
      ResultSet rs2=stmt2.executeQuery("select extension,count(fileid) as count from Files where extension!='folder' and owner='"+session.getAttribute("UserID")+"' group by extension");
        
                while(rs2.next())
      {
          out.print("{label : ' "+rs2.getString("extension")+"',");
          out.print("value: "+rs2.getString("count")+"},");
      }%>],
        resize: true
    });
    });
    </script>
</head>

<body>

    <div id="wrapper">

        <!-- Navigation -->
        <jsp:include page="navbar.jsp"/>

        <div id="page-wrapper">

            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Charts
                        </h1>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="index.html">Dashboard</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-bar-chart-o"></i> Disk Status
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

             
                <!-- /.row -->

                <div class="row">
                    <div class="col-lg-4">
                        <div class="panel panel-green">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-long-arrow-right"></i> Pie Chart </h3>
                            </div>
                            <div class="panel-body">
                                <div class="flot-chart">
                                    <div class="flot-chart-content" id="flot-pie-chart"></div>
                                </div>
                                <div class="text-right">
                                    <a href="fileStructure.jsp">View Details <i class="fa fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-8">
                            <div class="col-lg-12">
                        <h2>Your Files</h2>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover table-striped">
                                <thead>
                                    <tr>
                                        <th>File</th>
                                        <th>Downloads</th>
                                        <th>New Visits</th>
                                        <th>Size</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    
                                    <%
               Statement stmt3 = null;
                                 //STEP 4: Execute a query
      stmt3 = con.createStatement();
      ResultSet rs3=stmt3.executeQuery("select filename,count(fileid),count(fileid),size as count from Files where extension!='folder' and owner='"+session.getAttribute("UserID")+"' group by filename,size");
        
                while(rs3.next())
      {
          %>
          
                                    <tr>
                                        <td><%=rs3.getString(1)%></td>
                                        <td><%=rs3.getString(2)%></td>
                                        <td><%=rs3.getString(3)%></td>
                                        <td><%DecimalFormat df = new DecimalFormat("##.####");float d=Float.parseFloat(rs3.getString(4))/1024/1024; out.print(df.format(d));%> MB</td>
                                    </tr>          
          
                                    <%
      }%>
                                </tbody>
                            </table>
                        </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->


                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-yellow">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-long-arrow-right"></i> Donut Chart </h3>
                            </div>
                            <div class="panel-body">
                                <div id="morris-donut-chart"></div>
                                <div class="text-right">
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>
                <!-- /.row -->

            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    
    

    <!-- Morris Charts JavaScript -->
    <script src="js/plugins/morris/raphael.min.js"></script>
    <script src="js/plugins/morris/morris.min.js"></script>
    <script src="js/plugins/morris/morris-data.js"></script>

    <!-- Flot Charts JavaScript -->
    <!--[if lte IE 8]><script src="js/excanvas.min.js"></script><![endif]-->
    <script src="js/plugins/flot/jquery.flot.js"></script>
    <script src="js/plugins/flot/jquery.flot.tooltip.min.js"></script>
    <script src="js/plugins/flot/jquery.flot.resize.js"></script>
    <script src="js/plugins/flot/jquery.flot.pie.js"></script>
    <script src="js/plugins/flot/flot-data.js"></script>

</body>

</html>
