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

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

  <%session.setAttribute("Active","sendSMS"); %>
  
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
          
  <%
  if(request.getParameter("sendMsg")!=null)
  {
      String sender=request.getParameter("sender");
      String receiver=request.getParameter("receiver");
      String message=request.getParameter("message");
      
      PreparedStatement ps=con.prepareStatement("insert into Messages(sender,receiver,message,ontime) values('"+sender+"','"+receiver+"','"+message+"',getDate())");
      ps.executeUpdate();
  }
  %>
  
  
  <script>
      function loadChat(){
        var objDiv = document.getElementById("messageWindow");
        objDiv.scrollTop = objDiv.scrollHeight;
    }
  </script>
</head>

<body onload="loadChat()">

    <div id="wrapper">

        <jsp:include page="navbar.jsp"/>

        <div id="page-wrapper">

            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Inbox 
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
                        <div class='col-lg-4'>
                            
                            
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Users</th>
                                    </tr>
                                </thead>
                                <tbody>
                            <%
                            Statement stmt = null;
                                 //STEP 4: Execute a query
      stmt = con.createStatement();
      ResultSet rs=stmt.executeQuery("select userid,username from users where userid!='"+session.getAttribute("UserID")+"'");
        
      while(rs.next())
      {
          %>
            <tr class='info'>
                <td><a href='sendSMS.jsp?id=<%=rs.getString("userid")%>'><%=rs.getString("username")%></a></td>
            </tr>       
            <%
      }
            %>
                            
                            </tbody>
                            </table>
                        </div>
                        <div class='col-lg-8'>
                            
                        </div>
                        
                    </div>
            
            <div class="col-lg-8">
               
                <%
                if(request.getParameter("id")!=null)
                {
                %>
                <div class="panel panel-info">
                    <div class="row panel-heading alert-info" style="margin: 0px;">
                        <i class="fa fa-male"></i><strong>
                        <%
                        Statement stUser=con.createStatement();
                        ResultSet rsUser=stUser.executeQuery("select username from Users where userid='"+request.getParameter("id")+"'");
                        while(rsUser.next())
                        {
                            out.println(rsUser.getString(1));
                        }
                        %>
                        </strong>
                    </div>
                <div class="row panel-body" id='messageWindow' style='max-height:65vh;overflow-y: scroll;padding-bottom: 0px!important; margin: 0px;'>
               
                    <div class="col-lg-12">
                    <%
      Statement stmt2 = null;
                                 //STEP 4: Execute a query
      stmt2 = con.createStatement();
                    ResultSet rs2=stmt2.executeQuery("SELECT sender,u.username as senderName,receiver,message,cast(ontime as varchar(50)) as ontime FROM messages left join Users u on u.userid=sender where sender in ('"+session.getAttribute("UserID")+"','"+request.getParameter("id")+"') and receiver in ('"+session.getAttribute("UserID")+"','"+request.getParameter("id")+"')");


  while (rs2.next())
    {
    String sender = rs2.getString("sender");
    String receiver = rs2.getString("receiver");
    String msg = rs2.getString("message");
    String time = rs2.getString(5);
    
    if(sender.equals(session.getAttribute("UserID").toString()))
    {
    out.println("<div class='row' id='divmsg'>"+
        "<div class='col-sm-9 col-lg-9 col-md-9 col-xs-9'>"+
          "<div class='well' style='background-color:#66ccff;'><span style='font-size:20px;'>"+msg+"</span>"+
              "<div style='text-align:right;font-size:10px;'>"+time+"</div>"+
          "</div>"+
        "</div>"+
        "<div class='col-sm-3 col-lg-3 col-xs-3 col-md-3'>"+
          "<div class='well'>"+
        "<img src='img/person.png' class='img-circle' height='30' width='30' alt='Avatar'>"+
           "<span>"+session.getAttribute("Username")+"</span>"+
               
          "</div>"+
        "</div>"+
      "</div>");
    }else
    {
        
    out.println("  <div class='row'>"+
        "<div class='col-sm-3 col-lg-3 col-xs-3 col-md-3'>"+
          "<div class='well'>"+
        "<img src='img/person.png' class='img-circle' height='30' width='30' alt='Avatar'>"+
           "<span>"+rs2.getString("senderName")+"</span>"+
          "</div>"+
        "</div>"+
        "<div class='col-sm-9 col-lg-9 col-md-9 col-xs-9'>"+
          "<div class='well' style=''><span style='font-size:20px;'>"+msg+"</span>"+
              "<div style='text-align:right;font-size:10px;'>"+time+"</div>"+
          "</div>"+
        "</div>"+
      "</div>");
    }
    }
    

                    %>
                    
                </div>
                </div>
                    
            <div class="row panel-body" style="padding-bottom: 0px!important; margin: 0px;">
                
                <form method='POST'>
                    <div class='form-group input-group nopadding' >
                        <input type="hidden" name="sender" value='<%=session.getAttribute("UserID")%>' />
                        <input type="hidden" name="receiver" value='<%=request.getParameter("id")%>' />
                        
            <input type='text' class='form-control' name='message' placeholder='Type Your Message Here...'>
          <span class='input-group-btn'>
              <button class='btn btn-default' type='submit' name='sendMsg'>
              <span class='glyphicon glyphicon-send'></span>
            </button>
          </span>
        </div>
              </form>
            </div>
            
                </div>
                        <%}%>
            </div>
                </div>
            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->

    </div>
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
