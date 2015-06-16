window.routes =
  #-------- Admin part --------
  "admin_items":
    url:         '/admin/items'
    templateUrl: '/templates/admin_items/index.html'
    abstract: true
    data:
      feature: 'admin_items'

  "admin_items.list":
    url:         '/'
    views:
      'item_list':
        templateUrl: '/templates/admin_items/_item_list.html'
        controller: 'appAdminItemsCtrl'
      'categories_list':
        templateUrl: '/templates/categories/_categories_list.html'
        controller: 'appCategoriesCtrl'
    data:
      feature: 'admin_items'

  "admin_items.show":
    url:         '/:id'
    templateUrl: '/templates/admin_items/show.html'
    controller: 'appAdminItemCtrl'
    data:
      feature: 'admin_items'

  #-------- Public part --------
  "items":
    url:         '/items'
    templateUrl: '/templates/items/index.html'
    controller: 'appItemsCtrl'
    data:
      feature: 'items'
  "items_show":
    url:         '/items/:id'
    templateUrl: '/templates/items/show.html'
    controller: 'appItemCtrl'
    data:
      feature: 'items'

window.app.config ['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise("/items")
  for route, params of window.routes
    $stateProvider.state route, params
]
