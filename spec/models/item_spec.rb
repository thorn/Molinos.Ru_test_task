require 'rails_helper'

describe Item do
  let(:category) { FactoryGirl.create(:category) }
  let(:attr) { { name: "Item", price: 10.0, category_id: category.id, slug: 'slug' } }

  it 'creates item with valid attributes' do
    expect do
      Item.create(attr)
    end.to change { Item.count }.by(1)
  end

  describe 'associations' do
    it { should belong_to(:category) }

    it 'gets user from category delegate' do
      item = FactoryGirl.create(:item, category: category)
      expect(item.user).to eq(category.user)
    end
  end

  describe 'validations' do
    it { should allow_value(12.38).for(:price) }
    it { should_not allow_value(-12.38).for(:price) }
    it { should_not allow_value(nil).for(:price) }
    it { should validate_presence_of(:name) }
  end
end
