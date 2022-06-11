FactoryBot.define do
  factory :user do
    name { 'user' }
    email { 'user@user.com' }
    password { 'passwordpassword' }
    role { 'User' }
  end

  factory :admin, class: 'User' do
    name { 'admin' }
    email { 'admin@admin.com' }
    password { 'passwordpassword' }
    role { 'Admin' }
  end

  factory :super_admin, class: 'User' do
    name { 'super_admin' }
    email { 'super_admin@super_admin.com' }
    password { 'passwordpassword' }
    role { 'SuperAdmin' }
  end
end
