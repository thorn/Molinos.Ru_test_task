#= require ./common/common
#= require ./categories/categories
#= require ./items/items
#= require ./routes

window.app.controller 'appApplicationCtrl', ['$scope', '$rootScope', '$state', ($scope, $rootScope, $state)->
  $scope.state = $state
  $scope.alerts = []

  $rootScope.$on 'alert', (event, message, type='info') ->
    message = message || "Произошла ошибка!"
    type = 'danger' if type is 'error'
    $scope.alerts.push msg: message, type: type

  $scope.closeAlert = (index) ->
    $scope.alerts.splice(index, 1)

]
