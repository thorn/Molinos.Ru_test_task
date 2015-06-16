require 'rails_helper'

describe ItemsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:category) { FactoryGirl.create(:category) }
  let(:item) { FactoryGirl.create(:item) }
  let(:attr) { { name: 'New Item', category_id: category.id } }
  before { sign_in(user) }
  before { request.env['HTTP_ACCEPT'] = 'application/json' if defined? request }

  describe 'GET "index"' do
    it 'fetches item list' do
      get :index
      expect(assigns(:items)).to include(item)
    end

    it 'fetches items by category' do
      new_item = FactoryGirl.create(:item, category: category)
      item
      get :index, q: { category_id_in: category.id }
      expect(assigns(:items)).to include(new_item)
      expect(assigns(:items)).not_to include(item)
    end
  end

  describe 'GET "show"' do
    it 'fetches single item by it\'s slug' do
      item = FactoryGirl.create(:item, slug: 'my-slug')
      get :show, id: item.slug
      expect(assigns(:item)).to eq(item)
    end
  end
end
