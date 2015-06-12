FactoryGirl.define do
  factory :user do
    email
    password 'password'
    password_confirmation 'password'
  end

  sequence(:email) do |n|
    "user_#{n}@example.com"
  end
end
