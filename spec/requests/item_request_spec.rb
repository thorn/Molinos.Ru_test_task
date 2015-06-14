require 'rails_helper'

describe 'Item API' do
  let(:user) { FactoryGirl.create(:user, password: 'password') }
  before do
    post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => 'password'
  end

  it 'should render category with it\'s children' do
    cat = FactoryGirl.create(:category)
    item1 = FactoryGirl.create(:item, name: 'First item')
    item2 = FactoryGirl.create(:item, name: 'Second item', category_id: cat.id)
    get '/api/v1/items'
    expect(json).to eq([
      {
        "id" => item1.id,
        "name" => item1.name,
        "description" => item1.description,
        "price" => sprintf('%.2f', item1.price),
        "category_id" =>item1.category_id
      },
      {
        "id" => item2.id,
        "name" => item2.name,
        "description" => item2.description,
        "price" => sprintf('%.2f', item2.price),
        "category_id" =>item2.category_id
      }
    ])
  end

  it 'should create an item and respond with it' do
    category = FactoryGirl.create(:category)
    attr = { name: "New Item", description: "item description", category_id: category.id }
    post '/api/v1/items', item: attr
    expect(json.keys).to include("id", "name", "description", "category_id", "price")
  end
end