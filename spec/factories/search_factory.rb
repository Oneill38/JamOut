FactoryGirl.define do

  factory :user do
    email "example@example.com"
    name "example"
    password "password"
    password_confirmation "password"
  end

end
