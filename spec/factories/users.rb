# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "admin-#{n}@exmaple.com" }
    name { 'John Smith' }
    password { 'user password here' }
  end
end
