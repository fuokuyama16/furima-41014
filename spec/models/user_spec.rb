require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it 'nameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
      expect(@user).to be_valid
    end
    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'メールアドレスが一意性でなければ登録できない' do
      FactoryBot.create(:user, email: 'test@example.com')
      second_user = FactoryBot.build(:user, email: 'test@example.com')
      second_user.valid?
      expect(second_user.errors[:email]).to include('has already been taken')
    end
    it 'メールアドレスは、@を含む必要がある' do
      @user.email = 'invalid_email.com'
      @user.valid?
      expect(@user.errors[:email]).to include('is invalid')
    end
    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'パスワードは、6文字以下では登録できない' do
      @user.password = '12345'
      @user.password_confirmation = '12345'
      @user.valid?
      expect(@user.errors[:password]).to include('is too short (minimum is 6 characters)')
    end
    it 'パスワードが英字のみでは登録できない' do
      @user.password = 'abcdef'
      @user.password_confirmation = 'abcdef'
      @user.valid?
      expect(@user.errors[:password]).to include('は英字と数字の両方を含む必要があります')
    end
    it 'パスワードが数字のみでは登録できない' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors[:password]).to include('は英字と数字の両方を含む必要があります')
    end
    it 'パスワードと確認パスワードが一致しなければ登録できない' do
      @user.password = 'password123'
      @user.password_confirmation = 'password124'
      @user.valid?
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
    end
    it 'パスワードと確認パスワードが一致すれば登録できる' do
      @user.password = 'password123'
      @user.password_confirmation = 'password123'
      expect(@user).to be_valid
    end
    it '名字がないと登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors[:last_name]).to include("can't be blank")
    end
    it '名前がないと登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors[:first_name]).to include("can't be blank")
    end
    it '名字と名前があれば登録できる' do
      @user.first_name = '太郎'
      @user.last_name = '山田'
      expect(@user).to be_valid
    end
    it '名前が全角でなければ登録できない' do
      @user.first_name = 'Yamada'
      @user.last_name = 'Taro'
      @user.valid?
      expect(@user.errors[:first_name]).to include('は全角（漢字・ひらがな・カタカナ）で入力してください')
      expect(@user.errors[:last_name]).to include('は全角（漢字・ひらがな・カタカナ）で入力してください')
    end
    it '名字カナがなければ登録できない' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors[:last_name_kana]).to include("can't be blank")
    end
    it '名前カナがなければ登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors[:first_name_kana]).to include("can't be blank")
    end
    it '名字カナと名前カナがあれば登録できる' do
      @user.first_name_kana = 'タロウ'
      @user.last_name_kana = 'ヤマダ'
      expect(@user).to be_valid
    end
    it '名字カナが全角カタカナでなければ登録できない' do
      @user.last_name_kana = 'Yamada'
      @user.valid?
      expect(@user.errors[:last_name_kana]).to include('は全角（カタカナ）で入力してください')
    end
    it '名前カナが全角カタカナでなければ登録できない' do
      @user.first_name_kana = 'Taro'
      @user.valid?
      expect(@user.errors[:first_name_kana]).to include('は全角（カタカナ）で入力してください')
    end
    it '名字カナと名前カナが全角カタカナであれば登録できる' do
      @user.first_name_kana = 'タロウ'
      @user.last_name_kana = 'ヤマダ'
      expect(@user).to be_valid
    end
    it '生年月日が空では登録できない' do
      @user.birth_date = ''
      @user.valid?
      expect(@user.errors[:birth_date]).to include("can't be blank")
    end
  end
end
