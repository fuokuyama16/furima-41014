class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
    @categories = Category.all
    @conditions = Condition.all
    @shippingcosts = ShippingCost.all
    @prefectures = Prefecture.all
    @shippingdays = ShippingDay.all
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    @categories = Category.all
    @conditions = Condition.all
    @shippingcosts = ShippingCost.all
    @prefectures = Prefecture.all
    @shippingdays = ShippingDay.all
    if @item.save
      redirect_to root_path
    else
      puts @item.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_cost_id, :prefecture_id,
                                 :shipping_day_id, :price, :image, :user_id)
  end
end
