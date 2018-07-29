<!DOCTYPE HTML>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>275Project</title>
<meta name="description" content="" />
<meta name="viewport" content="width=device-width" />
<base href="/" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.5.0/angular.min.js"></script>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- <link rel="stylesheet" type="text/css"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" /> -->
	

<script type="text/javascript"
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"></script>
</head>
<body ng-app="app" ng-controller="home as home">
	<center><div class="container" style = "border:0.5px solid grey; width:400px; margin-top:100px; height:auto">
		<ul class="nav nav-tabs" style="width:150">
  			<li class="active" style = "width:50%"><a data-toggle="tab" href="#signIn">  <span class="glyphicon glyphicon-circle-arrow-right"></span>Sign In</a></li>
		    <li><a data-toggle="tab" style="width:181%" href="#register"><span class="glyphicon glyphicon-plus-sign"></span>Register</a></li>
		</ul>

		<div class="tab-content">
    		<div id="signIn" class="tab-pane fade in active">
 				<div class="form-group">
      				<input type="email" class="form-control" style="margin-top:15px;height:40px" placeholder="Email" name="emailId" ng-model="emailId"/>
      				<input type="password" class="form-control" style="margin-top:25px;height:40px" placeholder="password" name="loginPassword" ng-model="loginPassword"/>
      				<div><p font-color="red">{{invalid}}</p></div>
              		<button id="login" class="btn btn-primary" style="margin-top:25px;width:100%" value="Sign in" ng-click="home.login()">Login</button>
              		<a href="/connect/facebook"><button class="btn btn-primary" style="margin-top:5px;width:100%" >Facebook Login</button> </a>
              		 <a href="/connect/google"><button class="btn btn-primary" style="margin-top:5px;width:100%" >Google Login</button> </a>
            </div>
    		</div>
    	
    		<div id="register" class="tab-pane fade">
      			<div class="form-group">
      				<input type="email" class="form-control" style="margin-top:15px;height:40px" placeholder="Email" name="regEmail" ng-model="regEmail"/>
      				<input type="password" class="form-control" style="margin-top:10px;height:40px" placeholder="Password" name="password" ng-model="regPassword"/>
      				<input type="text" class="form-control" style="margin-top:10px;height:40px" placeholder="First Name" name="firstName" ng-model="firstName"/>
      				<input type="text" class="form-control" style="margin-top:10px;height:40px" placeholder="Last Name" name="lastName" ng-model="lastName"/>
      				<div><p font-color="red">{{invalid1}}</p></div>
      				<button ng-click="home.register()" class="btn btn-primary">Register</button>
      				<!-- <button class="btn btn-primary" style="margin-top:10px;width:100%" value="Register" ng-click="home.register()">Register</button> -->	
      			</div>
    		</div>
     	</div>
	</div></center>
	<!-- <div class="container" ng-show="!home.authenticated">
		<div>
			With Facebook: <a href="/connect/facebook">click here</a>
		</div>
		<div>
			With Google: <a href="/connect/google">click here</a>
		</div>
	</div> -->
	<div class="container" ng-show="home.authenticated">
		Logged in as: <span ng-bind="home.user"></span>
	</div>
	<div>
		<button ng-click="home.logout()" class="btn btn-primary">Logout</button>
	</div>
</body>
<script type="text/javascript" src="/webjars/angularjs/angular.min.js"></script>
<script type="text/javascript">
	angular.module("app", []).controller("home", function($scope, $http, $location, $window) {
		var self = this;
		$http.get("/user").success(function(data) {
			self.user = data.userAuthentication.details.name;
			self.authenticated = true;
		}).error(function() {
			self.user = "N/A";
			self.authenticated = false;
		});
		self.register = function() {
			$http.post('/userRegistration', {
				"regEmail":$scope.regEmail,
				"password":$scope.regPassword,
				"firstName":$scope.firstName,
				"lastName":$scope.lastName
			}).success(function(data) {
				if(data.statusCode=="200"){
				self.user = data.username;
					console.log("successfully Registered");
				}
				if (data.statusCode=="404"){
					$scope.invalid1 = "Failed to register, user already exists "
					console.log("failed to register, user already exsists");
				}
			}).error(function(data) {
				console.log("Logout failed")
				self.authenticated = false;
			});
		};

				
		self.login = function(){
			$http.post('/userLogin',{
				"email":$scope.emailId,
				"password":$scope.loginPassword
			}).success(function(data){
				if(data.statusCode=="200"){
					self.user = data.username;
					console.log("successfully Loged In");
					$window.location.href ="/mainPage";
				}else if(data.statusCode=="404"){
					$scope.invalid = "Failed to Login Invalid username or password";
				}
			})
		}

		
		self.logout = function() {
			$http.post('/logout', {}).success(function() {
				self.authenticated = false;
				$location.path("/");
			}).error(function(data) {
				console.log("Logout failed")
				self.authenticated = false;
			});
		};
	});
</script>
</html>