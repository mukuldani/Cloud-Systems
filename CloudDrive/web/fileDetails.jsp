<%@page import="java.util.Collections"%>
<%@page import="java.util.Arrays"%>
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
    <link href="css/glyphicons-filetypes.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

  <%session.setAttribute("Active","File"); %>
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
                            File Details
                        </h1>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="home.jsp">Dashboard</a>
                            </li>
                            <li>
                                <i class="fa fa-dropbox"></i>  <a href="fileStructure.jsp">My Drive</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-edit"></i> File Details
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->
                
                <jsp:include page="Connection.jsp"></jsp:include>
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
   
   String fileid=request.getParameter("fileid");

      //STEP 4: Execute a query
      stmt = con.createStatement();
      int lastNo=0;
      ResultSet rs=stmt.executeQuery("select * from files where fileid='"+fileid+"'");
      if(rs.next())
      {
          %>
                
                
                

                <div class="row"> 
                    <div class="col-lg-6">

                       
                            <div class="form-group">
                                <label>File Name</label>
                                <p class="help-block"><%=rs.getString("filename")%></p>
                            </div>

                            <div class="form-group">
                                <label>Display Name</label>
                                <p class="help-block"><%=rs.getString("displayname")%></p>
                            </div>

                            <div class="form-group">
                                <label>Chosen File</label>
                                <p class="help-block"><%=rs.getString("filename")%></p>                                
                            </div>
                            
                            <div class="form-group">
                                <label>Description</label>
                                <p class="help-block"><%=rs.getString("description")%></p>    
                            </div>
                            

                            <div class="form-group">
                                <label>Sent Alerts</label>
                                <div class="checkbox">
                                    <label>
                                        <input type="radio" name="txtAlerts" value="Publicly" <%if(rs.getString("alerts").equals("Publicly")) out.println("Checked");%> disabled/> Publish Publicly
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="radio" name="txtAlerts" value="Followers" <%if(rs.getString("alerts").equals("Followers")) out.println("Checked");%> disabled/> Followers
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="radio" name="txtAlerts" value="Private" <%if(rs.getString("alerts").equals("Private")) out.println("Checked");%> disabled/> Keep Private
                                    </label>
                                </div>
                            </div>
                                       <%
                                        String key="";
                            if(request.getParameter("user")==null)
                            {
                            %>
                            <div class="form-group">
                                <label>Encryption Technique</label>
                                <p class="help-block"><%=rs.getString("protection")%></p> 
                            </div>
                            <div class="form-group">
                                <label>Password</label>
                                <p class="help-block"><%
                                String pass=rs.getString("password");
            String result="",resultTemp="",resultActual="";
            char[] ascii=pass.toCharArray();
            int count=0;
            
            String atgs[]=new String[4];
            atgs[0]="00";
            atgs[1]="01";
            atgs[2]="10";
            atgs[3]="11";
            
            
            String A="",T="",G="",S="";
            
            String bit[]=new String[100];
            
            Integer[] arr = new Integer[4];
            for (int i = 0; i < arr.length; i++) {
                arr[i] = i;
            }
            Collections.shuffle(Arrays.asList(arr));
            //System.out.println(Arrays.toString(arr));
            
            for(int i=0;i<arr.length;i++)
            {
                //System.out.println(""+arr[i]);
                key+=arr[i];
            }
            
                A=atgs[arr[0]];
                T=atgs[arr[1]];
                G=atgs[arr[2]];
                S=atgs[arr[3]];
                           
            
              for(char ch:ascii){
                  resultTemp=Integer.toBinaryString(ch);
                  resultTemp=String.format("%08d",Integer.parseInt(resultTemp));
                result+=resultTemp+" ";
                resultActual+=resultTemp;
              }

              char[] twodigit=resultActual.toCharArray();
              
              for(int i=0;i<100;i++)
                  bit[i]="";
              for(int i=0;i<twodigit.length;i++)
              {
                  /*if(twodigit[i]==' ')
                  {
                      continue;
                  }else{*/
                  //System.out.print(""+twodigit[i]);
                  bit[count]+=twodigit[i];
                  if(i%2!=0)
                  {
                      //System.out.println("");
                      count++;
                  }
                  //}
              }
              String passwd="";
              for(int i=0;i<count;i++)
              {
                  if(bit[i].equals(A))
                      passwd+="A";
                  else if(bit[i].equals(T))
                      passwd+="T";
                  else if(bit[i].equals(G))
                      passwd+="G";
                  else if(bit[i].equals(S))
                      passwd+="S";
              }
              
              out.println(""+passwd);
                                %></p>
                            </div>
<%}%>

                    </div>
                    <div class="col-lg-6">
                            
                            <div class="form-group">
                                
                                <%
         
   Statement stmt2 = null;
  

      //STEP 4: Execute a query
      stmt2 = con.createStatement();
      ResultSet rs2=stmt2.executeQuery("select * from fileicons where filetype='"+rs.getString("extension")+"'");
      if(rs2.next())
      {
          %>
          <img src="<%=rs2.getString("location")%>" height="250vh" alt="txt" draggable="false"/>
                                <%
      }
      else
      {
          %>
          <img src="img/icons/config.png" height="250vh" alt="txt" draggable="false"/>
                                <%
      }
                                %>
                                
                                

                            </div>
                        
                            <div class="form-group">
                                <label>File Extension</label>
                                <p class="help-block"><%=rs.getString("extension")%></p> 
                            </div>
                        
                            <div class="form-group">
                                <label>File Size</label>
                                <p class="help-block"><%=rs.getString("size")%> Bytes (<%DecimalFormat df = new DecimalFormat("##.####");float d=Float.parseFloat(rs.getString("size"))/1024/1024; out.print(df.format(d));%> MB)</p> 
                            </div>
                        
                            <div class="form-group">
                                <label>Uploaded on </label>
                                <p class="help-block"><%=rs.getString("ontime")%></p> 
                            </div>
                            
                            <%
                            if(request.getParameter("user")==null)
                            {
                            %>
                            <div class="form-group">
                                <label>Key</label>
                                <p class="help-block"><%out.println(""+key);%></p> 
                            </div>
                            <%}%>
                            <div class="form-group">
                                <label>Total Upload Time Required</label>
                                <p class="help-block"><%=(double)Integer.parseInt(rs.getString("uploadTime"))/1000%> Sec</p> 
                            </div>
                            
              
                    </div>
                    
                </div>
                <!-- /.row -->
<%
      }
                %>
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

</body>

</html>
