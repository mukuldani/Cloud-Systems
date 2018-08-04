<%@page import="java.text.DecimalFormat"%>
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
                            Profile
                        </h1>
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-dashboard"></i> Dashboard
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

             

                
                
                

                
                <div class="container" style="min-height: 50vh;">
                 <div class="row">
        
                     <%
                     Connection con = null;
    String connectionUrl = "jdbc:sqlserver://localhost:1433;" +
			"databaseName=CloudSystems;user=sa;password=Bvimit@123;";
                

		// Declare the JDBC objects.
                    try{
        		// Establish the connection.
        		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                    //DriverManager.registerDriver(new sun.jdbc.odbc.JdbcOdbcDriver());
            		con = DriverManager.getConnection(connectionUrl);
                    }catch(Exception e)
                    {}
                     %>

                         <div class="table-responsive">
                            <table class="table table-bordered table-hover table-striped">
                                <tbody>
                                    
                                    <%
               Statement stmt3 = null;
                                 //STEP 4: Execute a query
      stmt3 = con.createStatement();
      ResultSet rs3=stmt3.executeQuery("select username,email,contact,planname,cast(ontime as varchar(50)) as  ontime from Users u left join Subscription s on s.userid=u.userid inner join Plans p on p.planid=s.planid  where u.userid='"+session.getAttribute("UserID")+"'");
        
                while(rs3.next())
      {
          %>
          
                                    <tr>
                                        <td>Name</td><td><%=rs3.getString("username")%></td>
                                         </tr> 
                                         <tr>
                                        <td>Email</td><td><%=rs3.getString("email")%></td>
                                         </tr>  
                                         <tr>
                                        <td>Contact</td><td><%=rs3.getString("contact")%></td>
                                    </tr>          
                                         <tr>
                                        <td>Subscribed Plan & Usage</td><td><%=rs3.getString("planname")%></td>
                                    </tr>           
                                         <tr>
                                        <td>Subscribed on</td><td><%=rs3.getString("ontime")%></td>
                                    </tr>          
          
                                    <%
      }%>
                                </tbody>
                            </table>
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
