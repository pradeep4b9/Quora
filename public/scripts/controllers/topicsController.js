angular
  .module('QuoraClone')
  .controller('topicsController', function($scope, $http, $location, $cookieStore, $routeParams) {

    $scope.topic = {};
    $scope.topic.topic = {};
    $scope.error = null;
    $scope.success = null;
    $scope.userTopics = {};

    $scope.init = function() {
      $scope.getTopics();
      $scope.getUserTopics();
      if($routeParams.id != null) {
        $scope.showTopic();
      }
    }

    $scope.getTopics = function() {
      $http({
        method : 'GET',
        url    : 'api/v1/topics'
      })
      .success(function(data) {
        $scope.topicsTemp = data;
        if(data.length == 0) {
          console.log(data);
          $scope.error = "No Topics! Please create a new topic";
        }
      })
      .error(function(data) {
        $scope.error = "Failed fetching Topics";
      })
    }

    $scope.getUserTopics = function() {
      $scope.topic = {};
      $scope.topic.topic = {};
      $scope.topic.topic.user_id = $cookieStore.get('userId');

      $http({
        method  : 'POST',
        url     : 'api/v1/user_topics',
        data    : $scope.topic,
        headers : {'Content-Type': 'application/json'}
      })
      .success(function(data) {
        $scope.userTopics = data;
        $scope.topics = $scope.topicsTemp;
        console.log(data);
      })
      .error(function(data) {
      })
    }

    $scope.showTopic = function() {

      $scope.topic.topic.id = $routeParams.id;

      $http({
        method    : 'POST',
        url       : 'api/v1/show_topic',
        data      : $scope.topic,
        headers   : {'Content-Type': 'application/json'}
      })
      .success(function(data) {
        $scope.topic = data;
        console.log(data);
      })
      .error(function(data) {
        $scope.error = "Failed fetching Topic";
      })
    }

    $scope.createTopic = function() {
      $http({
        method   : 'POST',
        url      : 'api/v1/topic',
        data     : $scope.topic,
        headers  : {'Content-Type': 'application/json'}
      })
      .success(function(data) {
        console.log(data);
        $scope.success = "Topic Created Successfully!";
      })
      .error(function(data) {
        $scope.error = "Could not create Topic!";
      })
    }


    $scope.followTopic = function(id) {

      $scope.topic = {};
      $scope.topic.topic = {};
      $scope.topic.topic.id = id;

      $http({
        method   : 'POST',
        url      : 'api/v1/follow_topic',
        data     : $scope.topic,
        headers  : {'Content-Type': 'application/json'}
      })
      .success(function(data) {
        $scope.success = "Now following: " + $scope.topics[$scope.topic.topic.id-1].title.capitalize();
        console.log(data);
      })
      .error(function(data) {
        $scope.error = "Could not follow topic";
      })
    }

    $scope.doesUserFollow = function(topicId) {
      flag = true;
      for(i = 0; i < $scope.userTopics.length; i++) {
        if($scope.userTopics[i].id == topicId) {
          flag = false;
          break;
        }
      }
      if(flag) {
        return true;
      }
      else {
        return false;
      }
    }
    $scope.redirectToQuestion = function(id) {
      $location.path("/question/" + id);
    }

    $scope.redirectToTopic = function(id) {
      $location.path("/topics/" + id);
    }

    $scope.redirectToCreateTopic = function() {
      $location.path("/topic/create");
    }


  });