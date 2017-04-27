FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :team do
    name { |n| "Team #{n}" }
    time { Time.now}
  end

  factory :user do
    email
    password "password"
    password_confirmation "password"
  end
end
