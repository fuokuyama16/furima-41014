class OrderAddressForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :street, :building, :phone_number, :token, :price

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :street
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid' }
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    order = Order.create(user_id:, item_id:, token:, postal_code:, prefecture_id:, city:, street:, building:, phone_number:)
    Address.create(postal_code:, prefecture_id:, city:, street:, building:,
                   phone_number:, order_id: order.id)
  end
end
