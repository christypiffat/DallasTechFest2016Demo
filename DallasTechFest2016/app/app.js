'use strict';

var app =
    angular.module('BlogApp', [
         'ngRoute',
         'breeze.angular'
    ]);

app.run(['$http', 'breeze', function ($http, breeze) {
}]);

app.config(['$routeProvider', function ($routeProvider) {

    $routeProvider.when("/home", {
        templateUrl: "app/views/blogView.html"
    });

    $routeProvider.when("/validate", {
        templateUrl: "app/views/blogValidationView.html"
    });

    $routeProvider.otherwise({
        redirectTo: "/home"
    });
}]);

