class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :check_item_owner!, only: [:edit]
  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to root_path
    else
      puts @item.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def check_item_owner!
    @item = Item.find(params[:id])
    redirect_to root_path if @item.user != current_user
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_cost_id, :prefecture_id,
                                 :shipping_day_id, :price, :image, :user_id)
  end
end
