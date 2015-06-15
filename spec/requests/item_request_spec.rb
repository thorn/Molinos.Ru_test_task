require 'rails_helper'

describe 'Item API' do
  let(:user) { FactoryGirl.create(:user, password: 'password') }
  before do
    post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => 'password'
  end

  it 'should render category with it\'s children' do
    cat = FactoryGirl.create(:category)
    item1 = FactoryGirl.create(:item, name: 'First item', category: nil)
    item2 = FactoryGirl.create(:item, name: 'Second item', category_id: cat.id)
    get '/api/v1/items'
    expect(json).to eq([
      {
        "id" => item2.id,
        "name" => item2.name,
        "description" => item2.description,
        "price" => sprintf('%.2f', item2.price),
        "category_id" => item2.category_id,
        "photos" => [],
        "photo_ids" =>[],
        "category" => { "id" => cat.id, "name" => cat.name, "sub_categories" => [] }
      },
      {
        "id" => item1.id,
        "name" => item1.name,
        "description" => item1.description,
        "price" => sprintf('%.2f', item1.price),
        "category_id" => item1.category_id,
        "photos"=>[],
        "photo_ids" => []
      }
    ])
  end

  it 'should create an item and respond with it' do
    category = FactoryGirl.create(:category)
    attr = { name: "New Item", description: "item description", price: 10.12, category_id: category.id }
    post '/api/v1/items', item: attr
    expect(json.keys).to include("id", "name", "description", "category_id", "price")
    expect(json.values).to include("New Item", "item description", category.id, "10.12")
  end
end
