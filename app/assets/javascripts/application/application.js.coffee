#= require ./common/common
#= require ./categories/categories
#= require ./items/items
#= require ./routes

window.app.controller 'appApplicationCtrl', ['$scope', '$state', ($scope, $state)->
  $scope.state = $state
  console.log('appApplicationCtrl')
]
