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
                            File Upload
                        </h1>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="home.jsp">Dashboard</a>
                            </li>
                            <li>
                                <i class="fa fa-dropbox"></i>  <a href="fileStructure.jsp">My Drive</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-edit"></i> File Upload
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

                <div class="row"> 
                    <form role="form"   method="post" action="uploadFile" enctype="multipart/form-data">
                    <div class="col-lg-6">

                       

                            <div class="form-group">
                                <label>Display Name</label>
                                <input class="form-control" name="txtDisplayName" placeholder="Enter Name for display">
                                <input class="form-control" type="hidden" name="txtParent" value="<%if(request.getParameter("parentid")!=null&&!request.getParameter("parentid").isEmpty()&&!request.getParameter("parentid").equals(""))
                                out.println(request.getParameter("parentid"));
                                else
                                out.println("");    
                                %>" placeholder="Enter Name for display">
                                
                                <p class="help-block">If it is left blank the default name will be taken</p>
                            </div>

                            <div class="form-group">
                                <label>Choose File</label>
                                <input type="file"  name="uploadFile"  class="filestyle" data-input="false" title="Please Select the File to be Uploaded" required/> 
                                
                            </div>
                            
                            <div class="form-group">
                                <label>Description</label>
                                <textarea class="form-control" name="txtDescription" rows="3" placeholder="Please Enter Description for that File"></textarea>
                            </div>
                            

                            <div class="form-group">
                                <label>Send Alerts</label>
                                <div class="checkbox">
                                    <label>
                                        <input type="radio" name="txtAlerts" value="Publicly" required/>Publish Publicly
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="radio" name="txtAlerts" value="Private" required/>Keep Private
                                    </label>
                                </div>
                            </div>

                       

                    </div>
                    <div class="col-lg-6">
                        
                            <div class="form-group">
                                <label>Encryption Technique</label>
                                <select class="form-control" name="txtEncryption">
                                    <option value="none">Select</option>
                                    <option>ATGC</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Password</label>
                                <input class="form-control" type="password" name="txtPassword" placeholder="Enter Password for your file">
                                <p class="help-block">If it is left blank then your file will be available for download without notification</p>
                            </div>
                    </div>
                    

                    <div class="col-lg-12 form-group">
                            <button type="submit" class="btn btn-default">Submit Button</button>
                            <button type="reset" class="btn btn-default">Reset Button</button>
                            
                    </div>
                         </form>
                </div>
                <!-- /.row -->

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
