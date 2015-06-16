window.app.factory 'ItemPublic',  ['$resource', ($resource) ->
  $resource('/items/:id', {id: '@slug'})
]

window.app.controller 'appItemsCtrl', ['$scope', 'ItemPublic', 'CurrentState', ($scope, ItemPublic, CurrentState) ->
  $scope.current_state = CurrentState

  $scope.items = []

  $scope.getItems = (params = {}) ->
    NProgress.start()
    ItemPublic.query params, (items) ->
      NProgress.done()
      CurrentState.items = items
      $scope.items = CurrentState.items
    , (data) ->
      NProgress.done()

  $scope.getItems()
]

window.app.controller 'appItemCtrl', ['$scope', 'ItemPublic', '$state', ($scope, ItemPublic, $state) ->
  $scope.state = $state.params
  $scope.item = ItemPublic.get(id: $state.params.id)
]
