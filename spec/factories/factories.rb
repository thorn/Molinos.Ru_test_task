FactoryGirl.define do
  factory :user do
    email
    password 'password'
    password_confirmation 'password'
  end

  factory :category do
    name
    user
    editable true
  end

  factory :item do
    name
    description "Item description"
    category
    slug 'slug'
  end

  sequence(:name) do |n|
    "name_#{n}"
  end

  sequence(:email) do |n|
    "user_#{n}@example.com"
  end
end
