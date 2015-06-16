json.id item.id
json.name item.name
json.description item.description
json.price sprintf('%.2f', item.price)
json.category_id item.category_id
json.slug item.slug
json.photos item.photos do |photo|
  json.partial! '/api/v1/photos/photo', photo: photo
end
json.photo_ids item.photo_ids
if item.category
  json.category do
    json.partial! '/api/v1/categories/category', category: item.category
  end
end
