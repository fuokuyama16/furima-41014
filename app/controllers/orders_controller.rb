class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :ensure_not_own_item, only: [:index, :create]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_address_form = OrderAddressForm.new
  end

  def create
    Rails.logger.debug "Received params: #{params.inspect}"
    @order_address_form = OrderAddressForm.new(order_params.merge(user_id: current_user.id))

    if @order_address_form.valid?
      pay_item
      @order_address_form.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address_form).permit(:postal_code, :prefecture_id, :city, :street, :building, :phone_number).merge(
      item_id: @item.id, user_id: current_user.id, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = 'sk_test_ec5947a3e9214d08ff66e213'
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def ensure_not_own_item
    return unless current_user == @item.user || @item.sold_out?

    redirect_to root_path
  end
end
