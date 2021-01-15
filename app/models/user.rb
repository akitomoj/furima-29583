class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items
  has_many :purchases

  with_options presence: true do
    validates :nickname
    validates :birthdate
  end

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて半角文字で設定してください'

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: 'には全角文字を使用してください' } do
    validates :first_name
    validates :last_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶ]+\z/, message: 'には全角カタカナを使用してください' } do
    validates :first_name_katakana
    validates :last_name_katakana
  end
end

# | nickname            | string | null: false               |
# | email               | string | null: false, unique: true |
# | encrypted_password  | string | null: false               |
# | last_name           | string | null: false               |
# | first_name          | string | null: false               |
# | last_name_katakana  | string | null: false               |
# | first_name_katakana | string | null: false               |
# | birthdate           | date   | null: false               |
# - has_many :items
# - has_many :purchases

# ## ユーザー情報
# - ニックネームが必須であること・・・クリア
# - メールアドレスが必須であること・・・devise
# - メールアドレスが一意性であること・・・devise
# - メールアドレスは@を含む必要があること・・・devise(https://nyoken.com/rails-devise-validation)
# - パスワードが必須であること・・・devise
# - パスワードは6文字以上であること・・・devise
# - パスワードは半角英数字混合であること・・・クリア
# - パスワードは確認用を含めて2回入力すること・・・devise
# - 新規登録・ログイン共にエラーハンドリングができていること（適切では無い値が入力された場合、情報は受け入れられず、エラーメッセージを出力させる）
