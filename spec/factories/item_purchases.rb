FactoryBot.define do
  factory :item_purchase do
    post_code         { '000-0000' }
    city              { '市でス' }
    address_number    { '番地でス' }
    building          { '建物名でス' }
    phone_number      { Faker::Number.leading_zero_number(digits: 10) }
    prefecture_id     { Faker::Number.within(range: 2..48) }
    token             {"tok_abcdefghijk00000000000000000"}
  end
end
