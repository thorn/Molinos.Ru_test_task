require 'rails_helper'

describe Category do
  let(:user) { FactoryGirl.create(:user) }
  let(:attr) { { name: "Category", editable: true, user_id: user.id } }

  it 'creates a record with valid attributes' do
    expect do
      Category.create(attr)
    end.to change { Category.count }.by(1)
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'ancestry' do
    it 'assigns parent record' do
      cat1 = FactoryGirl.create(:category, user: user)
      cat2 = FactoryGirl.create(:category, user: user, parent_id: cat1.id)
      expect(cat2.parent).to eq(cat1)
    end
  end
end
