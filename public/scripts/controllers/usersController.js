angular
  .module('QuoraClone')
  .controller('usersController', function($scope, $http, $location, $cookieStore, $routeParams) {

    $scope.firstName = "";
    $scope.lastName = "";
    $scope.followers = null;
    $scope.followings = null;
    $scope.avatarUrl = "";
    $scope.topics   = 0;
    $scope.user = {};
    $scope.user.user = {};
    $scope.question = {};
    $scope.question.question = {};
    $scope.question.question = {};
    $scope.followText = "Follow";
    $scope.error = null;
    $scope.success = null;
    $scope.success1 = null;
    $scope.success2 = null;
    $scope.click = true;

    $scope.init = function() {
      $scope.curUserId = $cookieStore.get('userId');
      $scope.userId = $routeParams.id;
      $scope.user.user.id = $scope.userId;
      $scope.question.question.user_id = $scope.userId;
      $scope.showProfile();
      $scope.showQuestions();
      $scope.showAnswers();
    }

    $scope.showProfile = function() {

      $http({
        method  : 'POST',
        url     : 'api/v1/show_user',
        data    : $scope.user, 
        headers : {'Content-Type': 'application/json'} 
       })
      .success(function(data) {
        if(data.success) {
          $scope.user = data;
          $scope.firstName = data.first_name;
          $scope.lastName  = data.last_name;
          $scope.avatarUrl = data.avatar;
          $scope.followers = data.followers;
          $scope.followings = data.followed_users;
          $scope.email     = data.email;
          $scope.topics    = data.topics;
          $scope.follow = $scope.checkFollowers($scope.user.id);
        }
        else {
          $scope.error = "Profile Fetch Error";
        }
      })
      .error(function(data) {
        $scope.error = "Profile Fetch Error";
      });
    }

    $scope.showQuestions = function() {
      $http({
        method  : 'POST',
        url     : 'api/v1/question_user',
        data    : $scope.question,
        headers : {'Content-Type': 'application/json'}
      })
      .success(function(data) {
        $scope.questions = data;
        if($scope.questions.length == 0) {
          $scope.success1 = "No Questions asked by " + $scope.firstName;
        }

      })
      .error(function(data) {
        $scope.error = "Question Fetch Error";
      })
    }

    $scope.showAnswers = function() {
      $scope.user = {};
      $scope.user.user = {};
      $scope.user.user.id = $scope.userId;
      $http({
        method  : 'POST',
        url     : 'api/v1/answer_user',
        data    : $scope.user,
        headers : {'Content-Type': 'application/json'}
      })
      .success(function(data) {
        $scope.answers = data;
        if($scope.answers.length == 0) {
          $scope.success2 = "No Questions answered by "+ $scope.firstName;
        }

      })
      .error(function(data) {
        $scope.error = "Answers Fetch Error";
      })
    }

    $scope.followUser = function(id) {
      $scope.relationships = {};
      $scope.relationships.relationships = {};
      $scope.relationships.relationships.followed_id = id;

      $http({
        method   : 'POST',
        url      : 'api/v1/relationships',
        data     : $scope.relationships,
        headers  : {'Content-Type': 'application/json'}
      })
      .success(function(data) {
        $scope.success = "Now following: " + $scope.firstName;
      })
      .error(function(data) {
        $scope.error = "Cannot follow!";
      })

    }

    $scope.unFollowUser = function(id) {

      $http({
        method   : 'DELETE',
        url      : 'api/v1/relationships?id=' + id,
        headers  : {'Content-Type': 'application/x-www-form-urlencoded'}
      })
      .success(function(data) {
        $scope.success = "Unfollowed: " + $scope.firstName;
      })
      .error(function(data) {
        $scope.error = "Cannot Unfollow!";
      })

    }

    $scope.checkFollowers = function() {
      console.log("Followers: ");
      console.log($scope.user.followers);
      flag = true;
      for(var i = 0; i < $scope.user.followers.length; i++) {
        if($scope.user.followers[i].id == $scope.curUserId) {
          flag = false;
          break;
        }
      }
      if(flag) {
        return false;
      }
      else {
        return true;
      }
    }

    $scope.redirectToQuestion = function(id) {
      $location.path("/question/" + id);
    }

    $scope.redirectToTopic = function(id) {
      $location.path("/topics/" + id);
    }

    $scope.showUser = function(id) {
      $location.path('/profile/' + id)
    }

  });