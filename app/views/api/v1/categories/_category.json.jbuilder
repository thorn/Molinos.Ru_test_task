json.id category.id
json.name category.name

json.sub_categories category.children do |child|
  json.partial! '/api/v1/categories/category', category: child
end
