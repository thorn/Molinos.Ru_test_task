require 'rails_helper'

describe Photo do
  let(:attr) { { image: 'image_path.png', main: true } }

  it 'should create photo with valid attributes' do
    expect do
      Photo.create(attr)
    end.to change{ Photo.count }.by(1)
  end

  describe 'associations' do
    it { should belong_to(:item) }
  end
end
