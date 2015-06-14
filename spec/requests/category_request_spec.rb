require 'rails_helper'

describe 'Categories API' do
  let(:user) { FactoryGirl.create(:user, password: 'password') }
  before do
    post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => 'password'
  end

  it 'should render category with it\'s children' do
    cat1 = FactoryGirl.create(:category, name: 'First category')
    cat2 = FactoryGirl.create(:category, name: 'Child category', parent_id: cat1.id)
    get '/api/v1/categories'
    expect(json).to eq([
      {
        "id" => cat1.id,
        "name" => cat1.name,
        "sub_categories" => [
          {
            "id" => cat2.id,
            "name" => cat2.name,
            "sub_categories" => []
          }
        ]
      }
    ])
  end
end
