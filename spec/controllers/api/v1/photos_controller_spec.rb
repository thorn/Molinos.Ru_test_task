require 'rails_helper'

describe Api::V1::PhotosController do
  include ActionDispatch::TestProcess
  let(:user) { FactoryGirl.create(:user) }
  let(:item) { FactoryGirl.create(:item) }
  let(:file) { fixture_file_upload('image.jpeg', 'image/jpeg', :binary) }
  let(:attr) { { image: file, item_id: item.id } }
  before { sign_in(user) }
  before { request.env['HTTP_ACCEPT'] = 'application/json' if defined? request }

  describe 'POST "create"' do
    it 'creates a item' do
      expect do
        post :create, photo: attr
      end.to change { Photo.count }.by(1)
    end

    it 'responds with error code' do
      post :create, photo: attr.merge(image: nil)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE "destroy"' do
    it 'deletes a record' do
      photo = FactoryGirl.create(:photo, image: file)
      expect do
        delete :destroy, id: photo.id
      end.to change{ Photo.count }.by(-1)
    end
  end
end
