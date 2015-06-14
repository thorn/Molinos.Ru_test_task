require 'rails_helper'

describe Api::V1::ItemsController do
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
    it 'fetches single item' do
      get :show, id: item.id
      expect(assigns(:item)).to eq(item)
    end
  end

  describe 'POST "create"' do
    it 'creates a item' do
      item
      expect do
        post :create, item: attr
      end.to change { Item.count }.by(1)
    end

    it 'responds with error code' do
      post :create, item: attr.merge(name: nil)
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'adds photos to item' do
      photo = FactoryGirl.create(:photo)
      post :create, item: attr.merge(photo_ids: [photo.id])
      expect(assigns(:item).photos).to include(photo)
    end
  end

  describe 'PATCH "update"' do
    it 'updates given record with new attributes' do
      expect do
        patch :update, id: item.id, item: attr.merge(name: 'new name')
        item.reload
      end.to change { item.name }.to('new name')
    end

    it 'responds with errors when wrong attributes are given' do
      patch :update, id: item.id, item: attr.merge(name: nil)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE "destroy"' do
    it 'deletes a record' do
      item
      expect do
        delete :destroy, id: item.id
      end.to change{ Item.count }.by(-1)
    end
  end
end
