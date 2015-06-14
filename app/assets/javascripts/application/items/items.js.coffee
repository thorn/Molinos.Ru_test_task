window.app.controller 'appItemsCtrl', ['$scope', 'currentState', ($scope, currentState) ->

  $scope.currentState = currentState

  $scope.$watch 'currentState.category', (category) ->
    console.log(category)
]
