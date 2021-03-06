FactoryBot.define do
  factory :user do
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password { 'passwordpassword' }
    role { 'User' }
    username { Faker::Internet.unique.username }

    factory :admin_user do
      role { 'Admin' }
    end

    factory :super_admin_user do
      role { 'SuperAdmin' }
    end
  end
end
