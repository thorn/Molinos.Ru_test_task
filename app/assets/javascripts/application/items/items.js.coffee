window.app.factory 'Item',  ['$resource', ($resource) ->
  $resource('/api/v1/items/:id', {id: '@id'},
    { update: {method:'PATCH'} }
  )
]

window.app.controller 'appItemCtrl', ['$scope', '$rootScope', 'Item', 'CurrentState', '$modal', 'Upload', '$http', '$state', ($scope, $rootScope, Item, CurrentState, $modal, Upload, $http, $state) ->
  $scope.state = $state.params
  $scope.item = Item.get(id: $state.params.id)
]

window.app.controller 'appItemsCtrl', ['$scope', '$rootScope', 'Item', 'CurrentState', '$modal', 'Upload', '$http', ($scope, $rootScope, Item, CurrentState, $modal, Upload, $http) ->
  $scope.current_state = CurrentState

  $scope.items = []

  $scope.getItems = (params = {}) ->
    NProgress.start()
    Item.query params, (items) ->
      NProgress.done()
      CurrentState.items = items
      $scope.items = CurrentState.items
    , (data) ->
      NProgress.done()

  $scope.editItem = (item) ->
    if item is 'new'
      $scope.item =
        category_id: $scope.current_state.category?.id
        photos: []
        photo_ids: []
    else
      $scope.itemBackup = angular.copy(item)
      $scope.item = item
    $scope.showForm()

  $scope.showForm = ->
    modalInstance = $modal.open
      templateUrl: '/templates/items/_item_form.html'
      scope: $scope
      controller: ($scope, $modalInstance) ->
        $scope.shouldBeOpen = true

        $scope.ok = ->
          $modalInstance.close($scope.item)

        $scope.cancel = ->
          $modalInstance.dismiss('cancel')

    modalInstance.result.then (item) ->
      $scope.saveItem(item)
    , ->
      angular.copy($scope.itemBackup, $scope.item);
      console.log 'Modal dismissed at: ' + new Date()

  $scope.saveItem = (item) ->
    if item.id
      item.$update (data) ->
        $rootScope.$emit 'items.edited', data
      , (data) ->
        $rootScope.$emit 'alert', 'Неверные данные', 'error'
        item.$get()
    else
      service = new Item(item: item)
      service.$save (data) ->
        $scope.items.unshift(data)
        $rootScope.$emit 'items.saved', data
      , (data) ->
        $rootScope.$emit 'alert', 'Не удалось сохранить товар', 'error'

  $scope.$watch 'current_state.category', (category = {}) ->
    console.log(category)
    $scope.getItems({'q[category_id_in]': category.id })

  $scope.upload = (files) ->
    NProgress.start()
    for file in files
      Upload.upload(
        file: file
        url: '/api/v1/photos'
        fileFormDataName: 'photo[image]'
        fields: {'photo[item_id]': $scope.item.id}
      ).success((data, status, headers, config) ->
        NProgress.done()
        $scope.item.photos.push(data)
        $scope.item.photo_ids.push(data.id)
      ).error((data, status, headers, config) ->
        NProgress.done()
        console.log data
      )

  $scope.delete = (photo) ->
    $http.delete("/api/v1/photos/#{photo.id}")
      .success((data) ->
        $scope.item.photos = $scope.item.photos.filter (photo) -> photo.id isnt data.id
        console.log data
      ).error((data) ->
        console.log data
      )
]
