FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name             { '苗字でス' }
    first_name            { '名前でス' }
    last_name_katakana    { 'ミョウジ' }
    first_name_katakana   { 'ナマエ' }
    birthdate             { '2020-12-31' }
  end
end
