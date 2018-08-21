<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>CLOUD STORAGE</title>

    <!-- Bootstrap Core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">

    <!-- Theme CSS -->
    <link href="css/grayscale.min.css" rel="stylesheet">
    <link href="css/custom1.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
	<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,800' rel='stylesheet' type='text/css'>
        <script src="js/jquery.min.js"></script> 
					<script type="text/javascript" src="js/jquery.placeholder.label.js"></script> 
					<script type="text/javascript">
                                            
                                                        function hideSignUp(){
                                                            var siginup = document.getElementById('signupDiv');
                                                            siginup.style.display = "none";
                                                        }
                                                       
                                                        
							$(document).ready(function (){
								$('input[placeholder]').placeholderLabel();
							})
                                                        
                                                        function siginup(){
                                                            var signupDiv = document.getElementById('signupDiv');
                                                            var login = document.getElementById('loginDiv');
                                                            login.style.display = "none";
                                                            signupDiv.style.display = "block";
                                                        }
                                                        
                                                        function login(){
                                                            var signupDiv = document.getElementById('signupDiv');
                                                            var login = document.getElementById('loginDiv');
                                                            login.style.display = "block";
                                                            signupDiv.style.display = "none";
                                                        }
                                                        
						</script>
                <%
                
           session.removeAttribute("UserID");
           session.removeAttribute("Username");
                %>                                            

    <script src="js/index.js"></script>
                                              
                                                
</head>

<body id="page-top" data-spy="scroll" data-target=".navbar-fixed-top" onload="hideSignUp()">

    <!-- Navigation -->
    <nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-main-collapse">
                    Menu <i class="fa fa-bars"></i>
                </button>
                <a class="navbar-brand page-scroll" href="#page-top">
                    <i class="fa fa-play-circle"></i> <span class="light">Start</span> STORING YOUR DATA
                </a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse navbar-right navbar-main-collapse">
                <ul class="nav navbar-nav">
                    <!-- Hidden li included to remove active class from about link when scrolled up past about section -->
                    <li class="hidden">
                        <a href="#page-top"></a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#about">About</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#download">Login</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#contact">Contact</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

    <!-- Intro Header -->
    <header class="intro">
        <div class="intro-body">
            <div class="container">
                <div class="row">
                    <div class="col-md-8 col-md-offset-2">
                        <h1 class="brand-heading">Cloud Storage</h1>
                        <p class="intro-text">robustness, confidentiality and functionality.
                            <br>Store your data online.</p>
                        <a href="#about" class="btn btn-circle page-scroll">
                            <i class="fa fa-angle-double-down animated"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- About Section -->
    <section id="about" class="container content-section text-center">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2">
                <h2>About Cloud Storage</h2>
                
                <p>The very best cloud storage solutions play nicely with other apps and services, making the experience of viewing or editing your files feel natural. Especially in business settings, you want your other software and apps to be able to retrieve or access your files, so making sure you use a service that easily authenticates with the other tools you use is a big deal. Box is particularly strong in this regard.</p>
            </div>
        </div>
    </section>

    <!-- Download Section -->
    <section id="download" class="content-section text-center">
        <div class="download-section">
            <div class="container">
                <div class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-6" id="loginDiv">
				
					<div class="col-lg-12 nopadding" >
									<div class="panel panel-default" style='opacity: 0.7;background-color:#fff;'>
					  <div class="panel-heading">Login</div>
					  <div class="panel-body nopadding" >
					  
                                                <form action="Login" method="POST">
                                                    <div class='form-group'>
                                                        <input id="loginEmail" name="loginEmail" type="email" placeholder="Enter your email" required/>
                                                    </div>
                                                    <div class='form-group'>
                                                        <input id="loginPassword" name="loginPassword" type="password" placeholder="Enter your password" required/>
                                                    </div>
                                                    <div class='form-group'>
                                                    <input type="submit"  value='Login'>
                                                    </div>
                                                    <div class='form-group'>
                                                        <button type="button" onclick="siginup()" class="btn btn-link">New User? Sign up</button>
                                                    </div>
						</form>
										   
					  </div>
					  </div>
					</div>
				</div>
				
                <div class="col-lg-6 col-lg-offset-3 col-md-6 col-md-offset-3" id="signupDiv">
				
					<div class="col-lg-12 nopadding" >
									<div class="panel panel-default" style='opacity: 0.7;background-color:#fff;'>
					  <div class="panel-heading">SIGN UP</div>
					  <div class="panel-body nopadding" >
                                     
					  
                                              <form action="Register" method="POST">
								<div class='form-group'>
								<input id="regName" name="regName" type="text" placeholder="Enter your name" pattern="[a-zA-Z\s]+" title="Please Enter the Name Correctly" required/>
								</div>
								<div class='form-group'>
								<input id="regEmail" name="regEmail" type="email" placeholder="Enter your email" required/>
								</div>
								<div class='form-group'>
                                                                    <input id="regPassword" name="regPassword" type="password" placeholder="Enter your password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" required/>
								</div>
								<div class='form-group'>
                                                                    <input id="regContact" name="regContact" type="text" placeholder="Contact Number" pattern="(?=.*\d).{10}" title="Please Enter Contact number Correctly" required/>
								</div>
                                                            
								<div class='form-group'>
								<input type="submit"  value='Register'>
								</div>
                                                                <div class='form-group'>
                                                                    <button type="button" onclick="login()" class="btn btn-link">Login</button>
                                                                </div>
							</form>
							   
						   
					  </div>
					  </div>
					</div>
				</div>
            </div>
        </div>
    </section>

    

    <!-- Footer -->
    <footer>
        <div class="container text-center">
            <p>Copyright &copy; Cloud Systems 2017</p>
        </div>
    </footer>

    <!-- jQuery 
    <script src="vendor/jquery/jquery.js"></script>-->

    <!-- Bootstrap Core JavaScript -->
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="js/jquery.easing.min.js"></script>

    <!-- Google Maps API Key - Use your own API key to enable the map feature. More information on the Google Maps API can be found at https://developers.google.com/maps/ -->
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCRngKslUGJTlibkQ3FkfTxj3Xss1UlZDA&sensor=false"></script>

    <!-- Theme JavaScript -->
    <script src="js/grayscale.min.js"></script>

</body>

</html>
