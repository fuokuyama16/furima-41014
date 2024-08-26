require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品できるとき' do
      it '商品名があれば登録できる' do
        @item.name = 'カバン'
        expect(@item).to be_valid
      end
      it '商品の説明があれば登録できる' do
        @item.description = '２０１０年頃に買った'
        expect(@item).to be_valid
      end
      it 'カテゴリIDが1以外の場合は有効である' do
        @item.category_id = 2
        expect(@item).to be_valid
      end
      it '状態IDがあれば登録できる' do
        @item.condition_id = 3
        expect(@item).to be_valid
      end
      it '配送料の負担IDがあれば登録できる' do
        @item.shipping_cost_id = 3
        expect(@item).to be_valid
      end
      it '発送元の地域IDがあれば登録できる' do
        @item.prefecture_id = 3
        expect(@item).to be_valid
      end
      it '発送までの日数IDあれば登録できる' do
        @item.shipping_day_id = 3
        expect(@item).to be_valid
      end
      it '価格があれば登録できる' do
        @item.price = 300
        expect(@item).to be_valid
      end
      it '画像があれば登録できる' do
        expect(@item).to be_valid
      end
    end
    context '新規登録できないとき' do
      it '商品名が空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品の説明が空では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'カテゴリIDが1の場合は登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '状態IDが1の場合は登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it '配送料の負担IDが1の場合は登録できない' do
        @item.shipping_cost_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping cost can't be blank")
      end
      it '発送元の地域IDが1の場合は登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送までの日数IDが1の場合は登録できない' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day can't be blank")
      end
      it '価格が空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '価格が300未満では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it '価格が9999999を超える場合は登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
      it '価格が半角数値以外では登録できない' do
        @item.price = '三百'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it '画像がなければ登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '出品者が紐づいていなければ登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
