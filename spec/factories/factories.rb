FactoryGirl.define do
  factory :user do
    email
    password 'password'
    password_confirmation 'password'
  end

  factory :category do
    name
    editable true
  end

  factory :item do
    name
    description "Item description"
    category
    slug 'slug'
  end

  factory :photo do
    image 'image.png'
    main false
    item
  end

  sequence(:name) do |n|
    "name_#{n}"
  end

  sequence(:email) do |n|
    "user_#{n}@example.com"
  end
end
