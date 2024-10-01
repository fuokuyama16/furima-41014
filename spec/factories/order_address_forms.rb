FactoryBot.define do
  factory :order_address_form do
    postal_code { '000-0000' }
    prefecture_id { 2 }
    city { 'Sapporo' }
    street { '1-2-3' }
    building { 'a-1' }
    phone_number { '00000000000' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
