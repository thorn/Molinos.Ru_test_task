window.routes =
  #-------- Categories and items --------
  "items":
    url:         '/items'
    templateUrl: '/templates/items/index.html'
    abstract: true
    data:
      feature: 'items'

  "items.list":
    url:         '/'
    views:
      'item_list':
        templateUrl: '/templates/items/_item_list.html'
        controller: 'appItemsCtrl'
      'categories_list':
        templateUrl: '/templates/items/_categories_list.html'
        controller: 'appCategoriesCtrl'
    data:
      feature: 'items'

  "items.show":
    url:         '/:id'
    templateUrl: '/templates/items/show.html'
    controller: 'appItemCtrl'
    data:
      feature: 'items'

window.app.config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise("/items/")
  for route, params of window.routes
    $stateProvider.state route, params
