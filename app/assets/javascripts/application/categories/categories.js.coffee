window.app.factory 'Category', ['$resource', ($resource) ->
  $resource('/api/v1/categories/:id', { id: '@id' },
    { update: { method: 'PATCH' } }
  )
]

window.app.controller 'appCategoriesCtrl', ['$scope', 'Category', 'CurrentState', '$modal', ($scope, Category, CurrentState, $modal) ->

  $scope.categories = []
  $scope.allCategories = []
  $scope.current_state = CurrentState

  $scope.getCategories = ->
    Category.query (categories) ->
      CurrentState.categories = categories
      $scope.categories = CurrentState.categories
      $scope.allCategories = []
      $scope.expandCategories(categories)
      CurrentState.allCategories = $scope.allCategories

  $scope.expandCategories = (categories) ->
    angular.forEach categories, (category) ->
      $scope.allCategories.push(category)
      $scope.expandCategories(category.sub_categories) if category.sub_categories.length > 0

  $scope.getCategories()

  $scope.selected = (category) ->
    CurrentState.category = category

  $scope.treeOptions =
    dropped: (event) ->
      source = event.source.nodeScope.$modelValue
      destination = event.dest.nodesScope.$parent.$modelValue
      if destination && destination.id
        params = { parent_id: destination.id }
      else
        params = { parent_id: null }
      Category.update({ id: source.id }, { category: params })

  $scope.editCategory = (category) ->
    if category is 'new'
      $scope.category = {}
    else
      $scope.categoryBackup = angular.copy(category)
      $scope.category = category
    $scope.showForm()

  $scope.showForm = ->
    modalInstance = $modal.open
      templateUrl: '/templates/categories/_category_form.html'
      scope: $scope
      controller: ($scope, $modalInstance) ->
        $scope.shouldBeOpen = true

        $scope.ok = ->
          $modalInstance.close($scope.category)

        $scope.cancel = ->
          $modalInstance.dismiss('cancel')

    modalInstance.result.then (category) ->
      $scope.saveCategory(category)
    , ->
      angular.copy($scope.itemBackup, $scope.category);
      console.log 'Modal dismissed at: ' + new Date()

  $scope.saveCategory = (category) ->
    if category.id
      category.$update (data) ->
        console.log data
      , (data) ->
        $rootScope.$emit 'alert', 'Неверные данные', 'error'
        category.$get()
    else
      service = new Category(category: category)
      service.$save (data) ->
        $scope.getCategories()
      , (data) ->
        $rootScope.$emit 'alert', 'Не удалось сохранить категорию', 'error'

  $scope.deleteCategory = (category) ->
    Category.delete {id: category.id}, (data) ->
      $scope.getCategories()
      console.log data
    , (data) ->
      $rootScope.$emit 'alert', 'Не удалось удалить категорию', 'error'

]
