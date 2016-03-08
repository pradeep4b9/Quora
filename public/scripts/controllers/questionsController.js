angular
  .module('QuoraClone')
  .controller('questionsController', function($scope, $http, $location, $cookieStore, $routeParams) {
    $scope.question = {};
    $scope.error = null;
    $scope.questions = null;

    $scope.answer = {}
    $scope.answer.answer  = {};

    $scope.init = function(val) {
      if(val == "feed") {
        $scope.questionFeed();
      }
      else if(val == "show") {
        $scope.showQuestion();
      }
    }

    $scope.addQuestion = function() {

      topics = $scope.question.question.topics;

      if(topics != null) {
        topics = topics.split(',');
        temp = topics.join('~').toLowerCase();
        topics = temp.split('~');
      }

      $scope.question.question.topics = topics;
      $scope.question.question.votes  = 0;

      $http({
        method  : 'POST',
        url     : 'api/v1/questions',
        data    : $scope.question, 
        headers : {'Content-Type': 'application/json'} 
       })
      .success(function(data) {

        if(data.success == true) {
          $scope.question = {};
          $location.path('/question/' + data.data.id);
        }
        else {
          $scope.error = data.info;
        }
      })
      .error(function(data) {
        $scope.error = "Add Question Error";  
      });
    }


    $scope.questionFeed = function() {
      $scope.question.question = {};
      $scope.question.question.user_id = $cookieStore.get('userId');

      $http({
        method   : 'POST',
        url      : 'api/v1/question_feed',
        data     : $scope.question,
        headers  : {'Content-Type': 'application/json'}
      })
      .success(function(data) {
        $scope.questions = data;
        if(data.length == 0) {
          $scope.error = "Please follow Topics to get Feed!"
        }
      })
      .error(function(data) {
        $scope.error = "Fetch Error";
      })
    }

    $scope.showQuestion = function() {
      $scope.question.question = {};
      $scope.question.question.id = $routeParams.id;

      $http({
        method    : 'POST',
        url       : 'api/v1/question',
        data      : $scope.question,
        headers   : {'Content-Type': 'application/json'}
      })
      .success(function(data) {
        $scope.question = data;
        console.log(data);
      })
      .error(function(data) {
        $scope.error = "Question Fetch Error";
      })
    }

    $scope.submitAnswer = function() {
      $scope.answer.answer.question_id = $routeParams.id;
      $scope.answer.answer.votes = 0;
      console.log("Answer: " + $scope.answer);

      $http({
        method    : 'POST',
        url       : 'api/v1/answers',
        data      : $scope.answer,
        headers   : {'Content-Type': 'application/json'}
      })
      .success(function(data) {
        $scope.success = "Answer Addedd!";
      })
      .error(function(data) {
        $scope.error = "Cannot answer";
      })
    }

    $scope.showUser = function(id) {
      $location.path('/profile/' + id)
    }

    $scope.redirectToQuestion = function(id) {
      $location.path("/question/" + id);
    }

    $scope.redirectToTopic = function(id) {
      $location.path("/topics/" + id);
    }


    $scope.showComments = function(id) {
      console.log(id);
      $location.path('/' + id + '/comments')
    }
  });