# encoding: utf-8
require 'rails_helper'

describe Item do
  let(:category) { FactoryGirl.create(:category) }
  let(:attr) { { name: "Item", price: 10.0, category_id: category.id } }

  it 'creates item with valid attributes' do
    expect do
      Item.create(attr)
    end.to change { Item.count }.by(1)
  end

  describe 'associations' do
    it { should belong_to(:category) }
    it { should have_many(:photos) }
  end

  describe 'validations' do
    it { should allow_value(12.38).for(:price) }
    it { should_not allow_value(-12.38).for(:price) }
    it { should_not allow_value(nil).for(:price) }
    it { should validate_presence_of(:name) }
  end

  describe 'slugs' do
    it 'creates a record with a slug based on the name' do
      item = Item.create!(attr.merge(name: 'Новое имя'))
      expect(item.slug).to eq('новое-имя')
    end
  end
end
