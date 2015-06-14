window.app.factory 'Category', ['$resource', ($resource) ->
  $resource('/api/v1/categories/:id', {id: '@id'},
    { update: {method:'PATCH'} }
  )
]

window.app.controller 'appCategoriesCtrl', ['$scope', 'Category', 'CurrentState', ($scope, Category, CurrentState) ->

  $scope.categories = []
  $scope.allCategories = []
  $scope.current_state = CurrentState

  $scope.getCategories = ->
    Category.query (categories) ->
      CurrentState.categories = categories
      $scope.categories = CurrentState.categories
      $scope.expandCategories(categories)
      CurrentState.allCategories = $scope.allCategories

  $scope.expandCategories = (categories) ->
    angular.forEach categories, (category) ->
      $scope.allCategories.push(category)
      $scope.expandCategories(category.sub_categories) if category.sub_categories.length > 0


  $scope.getCategories()

  $scope.refresh = ->
    $scope.getCategories()

  $scope.selected = (category) ->
    CurrentState.category = category
]
