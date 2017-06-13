FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :team_invite do
    email
    team
    team_user
  end

  factory :team_user do
    team
    user
    role TeamUser::OWNER
  end

  factory :blocker do
    body "MyText"
  end

  factory :team do
    name "MyTeam"
    time { Time.now}
  end

  factory :standup do
    standup "MyText"
  end

  factory :user do
    email
    password "password"
    password_confirmation "password"
    name "Dwight"
  end
end
