FactoryBot.define do
  factory :order_address_form do
    postal_code { '000-0000' }
    prefecture_id { 2 }
    city { 'Sapporo' }
    street { '1-2-3' }
    building { 'a-1' }
    phone_number { '00000000000' }
    token { 'tok_abcdefghijk00000000000000000' }

    after(:build) do |order_address_form|
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item, user:)
      order_address_form.user_id = user.id
      order_address_form.item_id = item.id
    end
  end
end
