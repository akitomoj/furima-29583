require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      # 9要素 = [nickname, email, password, password_confirmation, last_name, first_name, last_name_katakana, first_name_katakana, birthdate]
      it '9要素が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it '@がないemailは登録できない' do
        @user.email = 'test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください", "パスワードには英字と数字の両方を含めて半角文字で設定してください", "パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '0000a'
        @user.password_confirmation = '0000a'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが英語のみでは登録できない' do
        @user.password = 'aaabbb'
        @user.password_confirmation = 'aaabbb'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには英字と数字の両方を含めて半角文字で設定してください')
      end
      it 'passwordが数字のみでは登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには英字と数字の両方を含めて半角文字で設定してください')
      end
      it 'passwordが全角文字では登録できない' do
        @user.password = 'あああいいい1a'
        @user.password_confirmation = 'あああいいい1a'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには英字と数字の両方を含めて半角文字で設定してください')
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（姓）を入力してください", "名前（姓）には全角文字を使用してください")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（名）を入力してください", "名前（名）には全角文字を使用してください")
      end
      it 'last_name_katakanaが空では登録できない' do
        @user.last_name_katakana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（姓）カタカナを入力してください", "名前（姓）カタカナには全角カタカナを使用してください")
      end
      it 'first_name_katakanaが空では登録できない' do
        @user.first_name_katakana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（名）カタカナを入力してください", "名前（名）カタカナには全角カタカナを使用してください")
      end
      it 'birthdateが空では登録できない' do
        @user.birthdate = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("誕生日を入力してください")
      end
      it 'last_nameが全角（漢字・ひらがな・カタカナ）以外では登録できない' do
        @user.last_name = 's13'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前（姓）には全角文字を使用してください')
      end
      it 'first_nameが全角（漢字・ひらがな・カタカナ）以外では登録できない' do
        @user.first_name = 'm30'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前（名）には全角文字を使用してください')
      end
      it 'last_name_katakanaが全角（カタカナ）以外では登録できない' do
        @user.last_name_katakana = 'ひじ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前（姓）カタカナには全角カタカナを使用してください')
      end
      it 'first_name_katakanaが全角（カタカナ）以外では登録できない' do
        @user.first_name_katakana = 'さい'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前（名）カタカナには全角カタカナを使用してください')
      end
    end
  end
end

# ## ユーザー情報
# - ニックネームが必須であること・・・クリア
# - メールアドレスが必須であること・・・devise
# - メールアドレスが一意性であること・・・devise
# - メールアドレスは@を含む必要があること・・・devise(https://nyoken.com/rails-devise-validation)
# - パスワードが必須であること・・・devise
# - パスワードは6文字以上であること・・・devise
# - パスワードは半角英数字混合であること・・・クリア
# - パスワードは確認用を含めて2回入力すること・・・devise
# #本人情報確認
# - ユーザー本名が、名字と名前がそれぞれ必須であること
# - ユーザー本名は全角（漢字・ひらがな・カタカナ）で入力させること
# - ユーザー本名のフリガナが、名字と名前でそれぞれ必須であること
# - ユーザー本名のフリガナは全角（カタカナ）で入力させること
# - 生年月日が必須であること
