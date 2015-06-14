require 'rails_helper'

describe Photo do
  let(:item) { FactoryGirl.create(:item) }
  let(:attr) { { image: 'image_path.png', main: true, item_id: item.id } }

  it 'should create photo with valid attributes' do
    expect do
      Photo.create(attr)
    end.to change{ Photo.count }.by(1)
  end

  describe 'associations' do
    it { should belong_to(:item) }
  end

  describe 'validations' do
    # it { should validate_presence_of(:item_id) }
  end
end
