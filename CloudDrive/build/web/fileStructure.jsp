<%-- 
    Document   : fileStructure
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

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.js"></script>

  <link rel="stylesheet" href="css/custom.css">
  <script src="js/custom.js"></script>
  <%session.setAttribute("Active","File"); %>

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
                            My Drive
                            <small>Subheading</small>
                        </h1>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="home.jsp">Dashboard</a>
                            </li>
                            
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
  
                             if(request.getParameter("parentid")!=null&&!request.getParameter("parentid").isEmpty()&&!request.getParameter("parentid").equals(""))
                             {
                                 //STEP 4: Execute a query
      stmt = con.createStatement();
      int lastNo=0;
      ResultSet rs=stmt.executeQuery("select parentid,displayname from files where fileid='"+request.getParameter("parentid").trim()+"'");
      while(rs.next())
      {
          if(!rs.getString("parentid").trim().equals(""))
          {
          %>
          
          <li>
                                <i class="fa fa-dropbox"></i> <a href="fileStructure.jsp?parentid=<%=rs.getString("parentid")%>"><%=rs.getString("displayname")%></a>
                            </li>
                            <%
          }else
          {
              %>
                              <li class="active">
                                <i class="fa fa-dropbox"></i> <a href="fileStructure.jsp"><%=rs.getString("displayname")%></a>
                            </li>
                            <%
          }
      }
                                 %>
                            
                            <%
                             }else
                             {
                                 %>
                            <li class="active">
                                <i class="fa fa-dropbox"></i> My Drive
                            </li>
                            <%
                                 }
                            %>
                            
                            <li class='pull-right' style="margin-top: -8px!important;">
                                <span id='selectNav'>
                                </span>
                            </li>
                                
                        </ol>
                    </div>
                </div>
                
                <div class="row task">
                    <div class="col-lg-12 task__content" style="min-height: 80vh">
                        
                            <div class="row">
                            <div class="col-lg-12 col-xs-12">
                        <%
  
      //STEP 4: Execute a query
      stmt = con.createStatement();
      ResultSet rs=null;
      if(request.getParameter("parentid")!=null&&!request.getParameter("parentid").isEmpty()&&!request.getParameter("parentid").equals(""))
      {      rs=stmt.executeQuery("select fileid,displayname,isnull(location,'img/icons/config.png') as location from files f left join fileicons i on i.FileType=f.extension where owner='"+(String)session.getAttribute("UserID")+"' and extension='folder' and parentid = '"+request.getParameter("parentid")+"'");
      }
      else
      rs=stmt.executeQuery("select fileid,displayname,isnull(location,'img/icons/config.png') as location from files f left join fileicons i on i.FileType=f.extension where owner='"+(String)session.getAttribute("UserID")+"' and extension='folder'  and parentid=''");    
      while(rs.next())
      {
          %>
          
          <div id="FD<%=rs.getString("fileid")%>" class="well col-lg-2 col-sm-6 col-xs-4 form-group" style="margin: 20px;padding: 0px!important">
              
              <a class="btn btn-block col-lg-3" id="<%=rs.getString("fileid")%>"  onclick='singleClickFd(this.id)' ondblclick="doubleClickFd('fileStructure.jsp?parentid=<%=rs.getString("fileid")%>')" style="text-align: left;" draggable="false">
                  <img src="<%=rs.getString("location")%>" class="col-lg-4 col-xs-5" alt="doc" draggable="false"/><span style="margin: auto;vertical-align:middle;"><%=rs.getString("displayname")%></span>
              </a>
          </div>
          
                        <%
      }
                        %>
<script>
        function doubleClickFd(url) {
            window.location = url;
            return false;
        }
        function singleClickFd(id) {
            var div=document.getElementById('FD'+id);
            //alert('D'+id);
            if(div.style['background-color']==="rgb(170, 170, 170)")
            {
            div.style['background-color']="#f5f5f5";
            }
            else
            {
            div.style['background-color']="#aaa";
            }
        }
        </script> 
        


                        </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-lg-12 col-xs-12">
                        <%
      
   Statement stmt2 = null;
      //STEP 4: Execute a query
      stmt2 = con.createStatement();
      ResultSet rs2=null;
      if(request.getParameter("parentid")!=null&&!request.getParameter("parentid").isEmpty()&&!request.getParameter("parentid").equals(""))
        rs2=stmt2.executeQuery("select fileid,displayname,isnull(location,'img/icons/config.png') as location from files f left join fileicons i on i.FileType=f.extension where owner='"+(String)session.getAttribute("UserID")+"' and extension!='folder' and parentid = '"+request.getParameter("parentid")+"'");
      else
      rs2=stmt2.executeQuery("select fileid,displayname,isnull(location,'img/icons/config.png') as location,url from files f left join fileicons i on i.FileType=f.extension where owner='"+(String)session.getAttribute("UserID")+"' and extension!='folder'  and parentid=''");    
      while(rs2.next())
      {
          %>
          
          <div id="D<%=rs2.getString("fileid")%>"  class="well col-lg-2 col-sm-6 col-xs-4 form-group" style="margin: 20px;">
              <img src="<%=rs2.getString("location")%>" style="max-height: 15vh;" class="col-lg-12 col-xs-12" alt="doc" draggable="false"/>
              <a id="<%=rs2.getString("fileid")%>"  onclick='singleClickF(this.id,"<%=rs2.getString("url")%>")' ondblclick="doubleClickF('fileDetails.jsp?fileid=<%=rs2.getString("fileid")%>')" draggable="false"><span style="font-size: 10px;"><%=rs2.getString("displayname")%></span></a>
                        </div>
          
                        <%
      }
                        %>

                    <script>
        function doubleClickF(url) {
            window.location = url;
            return false;
        }
        function singleClickF(id,url) {
            var div=document.getElementById('D'+id);
            sessionStorage.setItem("fileID",""+id);
            localStorage.setItem("fileID", id);
            //alert('D'+id);
            if(div.style['background-color']==="rgb(170, 170, 170)")
            {
            div.style['background-color']="#f5f5f5";
            
            $("#shareNav").remove();
            }
            else
            {
            div.style['background-color']="#aaa";
            var ul = $("<ul id='shareNav' class='pull-left breadcrumb'><li><a href='"+url+"'  target='_blank'><i class='glyphicon glyphicon-open'></i>  View</a></li><li><a data-toggle='modal' data-target='#shareFile'><i class='fa fa-share'></i>  Share</a></li></ul>");
            
            $("#selectNav").append(ul);
            }
        }
                    </script>    
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
                        <!-- Modal -->
<div id="myModal" class="modal fade " role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Add Folder</h4>
      </div>
        <form action="dbAddFolder.jsp" method="POST">
            <div class="modal-body">
                
                 
               <div class="form-group">
                  <label>Folder Name</label>
                  <input class="form-control" name="txtFolderName" placeholder="Enter Name of the Folder" required/>
                  <input class="form-control" type="hidden" name="txtParent" value="<%if(request.getParameter("parentid")!=null&&!request.getParameter("parentid").isEmpty())out.println(request.getParameter("parentid"));else out.println("");%>"/>
              </div>
                <div class="form-group">
                    <label>Encryption Technique</label>
                    <select class="form-control" name="txtEncryption">
                        <option value="none">Select</option>
                        <option>ATGS</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input class="form-control" type="password" name="txtPassword" placeholder="Enter Password for your file">
                </div>
            </div>
            <div class="modal-footer">
                 <button type="submit" class="btn btn-default">Submit</button>
            </div>
        </form>
    </div>

  </div>
</div>
              
            
              
              <!-- Modal -->
  <div class="modal fade" id="shareFile" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Share File</h4>
        </div>
          <form action="dbShareFile.jsp" method="POST">
              <div class="modal-body">
          
            <div class="form-group">
                  <label>Select User</label>
                  <input type="hidden" name="txtFile" id='txtFile'/>
                  <script>
                  function fillValue(){
                  var d=document.getElementById('txtFile');
                  //alert(sessionStorage.getItem("fileID"));
                  d.value=sessionStorage.getItem("fileID");
                  //d.value=localStorage.getItem("fileID");
                  //d.value='1';
              }
              fillValue();
              </script>
                  
                  <select class='form-control' name="txtUser" required>
                      <option>Select</option>
                      
                      <%
                      
                  Statement stSend=con.createStatement();
                  ResultSet rsSend=stSend.executeQuery("select * from Users where userid!='"+session.getAttribute("UserID")+"'");
                  while(rsSend.next())
                  {
                      out.print("<option value='"+rsSend.getString("userid")+"'>"+rsSend.getString("username")+"</option>");
                  }
                      %>
                                            
                  </select>
            </div>
            
        </div>
                      
                         
        <div class="modal-footer">
          <button type="Submit" class="btn btn-default">Share</button>
        </div>
          </form>
      </div>
      
    </div>
  </div>
  
                        
<ul class='custom-menu'>
    <%if(request.getParameter("parentid")!=null&&!request.getParameter("parentid").isEmpty()&&!request.getParameter("parentid").equals("")){%>
    <li><a class="btn btn-block" style="text-align: left!important;" href="file.jsp?parentid=<%=request.getParameter("parentid")%>"><i class="glyphicon glyphicon-file"></i> Add File</a></li>
    <%}else{%>
    <li><a class="btn btn-block" style="text-align: left!important;" href="file.jsp"><i class="glyphicon glyphicon-file"></i> Add File</a></li>
    <%}%>
  <li><a class="btn btn-block" style="text-align: left!important;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-folder-open"></i>  Add Folder</a></li>
  <li><a class="btn btn-block" style="text-align: left!important;" href="#"><i class="glyphicon glyphicon-stats"></i>  Get Drive Status</a></li></li>
</ul>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

  
</body>

</html>
