require 'rails_helper'

RSpec.describe OrderAddressForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user: @user)
    @order_address_form = FactoryBot.build(:order_address_form, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入機能' do
    context '商品購入できる時' do
      it '全て正常に入力されていれば保存できる' do
        expect(@order_address_form).to be_valid
        expect(@order_address_form.save).to be_truthy
      end

      it '建物名がなくても登録できる' do
        @order_address_form.building = ''
        expect(@order_address_form).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号が空では登録できない' do
        @order_address_form.postal_code = ''
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号がハイフンなしでは登録できない' do
        @order_address_form.postal_code = '1234567'
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it '都道府県が選択されていない場合、登録できない' do
        @order_address_form.prefecture_id = 1
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空では登録できない' do
        @order_address_form.city = ''
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では登録できない' do
        @order_address_form.street = ''
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include("Street can't be blank")
      end

      it '電話番号が空では登録できない' do
        @order_address_form.phone_number = ''
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が9桁以下では登録できない' do
        @order_address_form.phone_number = '090-123-567'
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号が12桁以上では登録できない' do
        @order_address_form.phone_number = '0900-1234-5678'
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号に半角数字以外が含まれている場合は購入できない' do
        @order_address_form.phone_number = '0900-1234-56a'
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include('Phone number is invalid')
      end

      it 'tokenが空では登録できないこと' do
        @order_address_form.token = nil
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include("Token can't be blank")
      end

      it 'itemが紐付いていなければ購入できない' do
        @order_address_form.item_id = nil
        expect(@order_address_form).to_not be_valid
        expect(@order_address_form.errors.full_messages).to include("Item can't be blank")
      end

      it 'userが紐付いていなければ購入できない' do
        @order_address_form.user_id = nil
        expect(@order_address_form).to_not be_valid
        expect(@order_address_form.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end
