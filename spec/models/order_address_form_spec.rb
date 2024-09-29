require 'rails_helper'

RSpec.describe OrderAddressForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user: @user)
    @order_address_form = FactoryBot.build(:order_address_form, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入機能' do
    context '商品購入できる時' do
      it '郵便番号があれば登録できる' do
        @order_address_form.postal_code = '000-0000'
        expect(@order_address_form).to be_valid
      end

      it '郵便番号は「3桁ハイフン4桁」の半角文字列であれば登録できる' do
        @order_address_form.postal_code = '123-4567'
        expect(@order_address_form).to be_valid
      end

      it '都道府県があれば登録できる' do
        @order_address_form.prefecture_id = 2
        expect(@order_address_form).to be_valid
      end

      it '市区町村があれば登録できる' do
        @order_address_form.city = 'Sapporo'
        expect(@order_address_form).to be_valid
      end

      it '番地があれば登録できる' do
        @order_address_form.street = '1-2-3'
        expect(@order_address_form).to be_valid
      end

      it '建物名がなくても登録できる' do
        @order_address_form.building = ''
        expect(@order_address_form).to be_valid
      end

      it '電話番号があれば登録できる' do
        @order_address_form.phone_number = '09012345678'
        expect(@order_address_form).to be_valid
      end

      it '電話番号は10桁以上11桁以内の半角数値であれば登録できる' do
        @order_address_form.phone_number = '09012345678'
        expect(@order_address_form).to be_valid
      end

      it 'tokenがあれば保存ができること' do
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

      it '電話番号が適切なフォーマットでないと登録できない' do
        @order_address_form.phone_number = '090-1234-5678'
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include('Phone number is invalid')
      end

      it 'tokenが空では登録できないこと' do
        @order_address_form.token = nil
        @order_address_form.valid?
        expect(@order_address_form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
