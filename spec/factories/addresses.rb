FactoryBot.define do
  factory :address do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '東京都' }
    street { '渋谷区道玄坂' }
    building { '渋谷ビル' }
    phone_number { '09012345678' }
    association :order
  end
end
