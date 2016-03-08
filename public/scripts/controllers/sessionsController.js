angular
  .module('QuoraClone')
  .controller('sessionsController',function ($scope, $http, $location, $cookieStore, $routeParams, Upload) {
    $scope.user = {};
    $scope.newUser = {};
    $scope.isLogin = false;

    $scope.init = function() {
      $http({
        method  : 'GET',
        url     : 'api/v1/sessions'
      })
      .success(function(data) {
        $scope.isLogin = true;
        return true;
      })
      .error(function(data) {
        $scope.isLogin = false;
        return false;
      })

    }

    $scope.showSelf = function() {
      $location.path("/profile/" + $cookieStore.get('userId'));
    }

    $scope.login = function() {

      $http({
        method  : 'POST',
        url     : 'api/v1/sessions',
        data    : $scope.user, 
        headers : {'Content-Type': 'application/json'} 
       })
      .success(function(data) {
        if(data.success) {
          $cookieStore.put('rememberToken', data.data.remember_token);
          $cookieStore.put('userId', data.data.user_id);
          $scope.isLogin = true;
          $location.path('/');
        }
        else {
          $scope.error = data.info;
        }
      })
      .error(function(data) {
        $scope.error = "Login Error";  
      });
    }
  

    $scope.logout = function() {

      if($scope.isLogin) {
        $http({
          method  : 'DELETE',
          url     : 'api/v1/sessions',
          data    :  $.param({remember_token: $cookieStore.get('rememberToken')}),
          headers : {'Content-Type': 'application/x-www-form-urlencoded'}
        })
         .success(function(data) {
            if(data.success) {
              $cookieStore.remove('rememberToken');
              $cookieStore.remove('userId');
              $location.path('/');
            }
            else {
              $scope.error = data.info;
            }
         })
         .error(function(data) {
            $scope.error = "Logout Error"
         });
      }
    }

    $scope.checkLogin = function() {
      if($cookieStore.get('rememberToken') == null) {
        $scope.isLogin = false;
        return false;
      }
      else {
        $scope.isLogin = true;
        return true;
      }
    }

    $scope.submit = function() {
      if ($scope.form.file.$valid) {
        $scope.signup($scope.file);
      }
      else {
        $scope.error = "Invalid File!";
      }
    }

    $scope.signup = function (file) {
      if($scope.newUser.user.password == $scope.newUser.user.password_confirmation) {
        $scope.newUser.user.avatar = file;
        delete $scope.newUser.user.password_confirmation;

        Upload.upload({
            url: 'api/v1/users',
            data: $scope.newUser
        })
        .success(function(data) {
            if(data.success) {
              $cookieStore.put('rememberToken', data.data.remember_token);
              $cookieStore.put('userId', data.data.user_id);
              $scope.isLogin = true;
              $location.path('/');
            }
            else {
              $scope.error = data.info;
            }
          })
          .error(function(data) {
            $scope.error = "Signup Error";  
          });
      }
      else {
        $scope.error = "Password Does not Match!";
      }
    }

  });