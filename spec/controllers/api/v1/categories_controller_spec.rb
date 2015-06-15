require 'rails_helper'

describe Api::V1::CategoriesController do
  let(:user) { FactoryGirl.create(:user) }
  let(:category) { FactoryGirl.create(:category, editable: true) }
  let(:attr) { { name: 'child_category', parent_id: category.id } }
  before { sign_in(user) }
  before { request.env['HTTP_ACCEPT'] = 'application/json' if defined? request }

  describe 'GET "index"' do
    it 'fetches category list' do
      child = FactoryGirl.create(:category, parent_id: category.id)
      get :index
      expect(assigns(:categories)).to include(category)
      expect(assigns(:categories)).not_to include(child)
    end
  end

  describe 'GET "show"' do
    it 'fetches single category' do
      get :show, id: category.id
      expect(assigns(:category)).to eq(category)
    end
  end

  describe 'POST "create"' do
    it 'creates a category' do
      category
      expect do
        post :create, category: attr
      end.to change { Category.count }.by(1)
    end

    it 'responds with error code' do
      post :create, category: attr.merge(name: nil)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PATCH "update"' do
    it 'updates given record with new attributes' do
      expect do
        patch :update, id: category.id, category: attr.merge(name: 'new name', parent_id: nil)
        category.reload
      end.to change { category.name }.to('new name')
    end

    it 'responds with errors when wrong attributes are given' do
      patch :update, id: category.id, category: attr.merge(name: nil)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE "destroy"' do
    it 'deletes record but does not deletes children' do
      child_category = FactoryGirl.create(:category, parent_id: category.id)
      expect do
        delete :destroy, id: category.id
        child_category.reload
        expect(child_category.parent).to eq(nil)
      end.to change{ Category.count }.by(-1)
    end
  end
end
