angular
  .module('QuoraClone')
  .config(['$routeProvider', function($routeProvider) {
    $routeProvider
      .when("/", {templateUrl: "partials/home.html"})
      .when("/login", {templateUrl: "partials/login.html"})
      .when("/signup", {templateUrl: "partials/updateProfile.html"})
      .when("/profile/:id", {templateUrl: "partials/profile.html"})
      .when("/addQuestion", {templateUrl: "partials/addQuestion.html"})
      .when("/question/:id", {templateUrl: "partials/question.html"})
      .when("/questionFeed", {templateUrl: "partials/questionFeed.html"})
      .when('/:answerId/comments', {templateUrl: "partials/comment.html"})
      .when('/topics/:id', {templateUrl: "partials/topic.html"})
      .when('/topics', {templateUrl: "partials/topics.html"})
      .when('/topic/create', {'templateUrl': 'partials/addTopic.html'})
      .when("/404", {templateUrl: "partials/404.html"})
      .otherwise({
        redirectTo: '/404'
      })
  }])
  .config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeBar = true;
    cfpLoadingBarProvider.includeSpinner = false;
  }]);

