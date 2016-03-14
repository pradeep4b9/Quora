angular
  .module('QuoraClone')
  .controller('commentsController', function($scope, $http, $location, $cookieStore, $routeParams) {

    $scope.answerId = $routeParams.answerId;
    $scope.comment = {};
    $scope.comment.comment = {};
    $scope.error = null;
    $scope.success = null;

    $scope.init = function() {

      $scope.comment.comment.answer_id = $scope.answerId;

      $http({
        method   : 'POST',
        url      : 'api/v1/get_comments',
        data     : $scope.comment,
        headers  : {'Content-Type': 'application/json'}
      })
      .success(function(data) {
        $scope.comments = data;
        console.log(data);
      })
      .error(function(data) {
        $scope.error = "Comment Fetch Error!"
      })

    }

    $scope.submitComment = function() {
      $scope.comment.comment.answer_id = $scope.answerId;

      $http({
        method   : 'POST',
        url      : 'api/v1/comments',
        data     : $scope.comment,
        headers  : {'Content-Type': 'application/json'}
      })
      .success(function(data) {
        $scope.success = "Comment Added Successfully!";
      })
      .error(function(data) {
        $scope.error = "Cannot Comment!";
      })
    }

    $scope.showUser = function(id) {
      $location.path('/profile/' + id)
    }


  });