window.app.factory 'Category', ['$resource', ($resource) ->
  $resource('/api/v1/categories/:id', {id: '@id'},
    {
      update: {method:'PATCH'}
    }
  )
]

window.app.controller 'appCategoriesCtrl', ['$scope', 'Category', 'currentState', ($scope, Category, currentState) ->

  $scope.categories = []
  $scope.currentState = currentState
  $scope.all = { name: "Все товары" }
  $scope.getCategories = ->
    Category.query (categories) ->
      $scope.categories = categories
      $scope.currentState.category = null

  $scope.getCategories()

  $scope.refresh = ->
    $scope.getCategories()

  $scope.selected = (category) ->
    $scope.currentState.category = category
]
