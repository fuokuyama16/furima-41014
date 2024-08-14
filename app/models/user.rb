class User < ApplicationRecord
  validates :nickname, presence: true
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }
  validates :last_name,  presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角（カタカナ）で入力してください' }
  validates :last_name_kana,  presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角（カタカナ）で入力してください' }
  validates :password, confirmation: true, length: { within: 6..128 },
                       format: { with: /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]+\z/, message: 'は英字と数字の両方を含む必要があります' }
  validates :password_confirmation, presence: true
  validates :birth_date, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
