require 'rails_helper'

RSpec.describe ItemPurchase, type: :model do
  before do
    @address = FactoryBot.build(:item_purchase)
    user = FactoryBot.build_stubbed(:user).id
    item = FactoryBot.build_stubbed(:item).id
    @address.user_id = user
    @address.item_id = item
  end

  describe '商品購入での住所情報' do
    context '住所登録できるとき' do
      # 8要素 = :purchase_id, :post_code, :prefecture_id, :city, :address_number, :building, :phone_number
      it '8要素とtoken、user_idとitem_idが存在すれば登録できる' do
        expect(@address).to be_valid
      end
      it 'buildingがnilでも登録できる' do
        @address.building = ''
        expect(@address).to be_valid
      end
      it 'phone_numberが11文字でも登録できる' do
        @address.phone_number = '08012345678'
        expect(@address).to be_valid
      end
    end
    context '住所登録できないとき' do
      it 'post_codeが空では登録できない' do
        @address.post_code = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("郵便番号を入力してください", "郵便番号は無効です。ハイフン(-)を含めてください")
      end
      it 'cityが空では登録できない' do
        @address.city = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'address_numberが空では登録できない' do
        @address.address_number = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("建物名を入力してください")
      end
      it 'phone_numberが9文字以下では登録できない' do
        @address.phone_number = '090123456'
        @address.valid?
        expect(@address.errors.full_messages).to include('電話番号は無効です。ハイフン(-)を含めてください')
      end
      it 'phone_numberが12文字以上では登録できない' do
        @address.phone_number = '080123456789'
        @address.valid?
        expect(@address.errors.full_messages).to include('電話番号は無効です。ハイフン(-)を含めてください')
      end
      it 'prefecture_idが1では登録できない' do
        @address.prefecture_id = 1
        @address.valid?
        expect(@address.errors.full_messages).to include("都道府県を入れてください")
      end
      it 'phone_numberが空では登録できない' do
        @address.phone_number = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("電話番号を入力してください", "電話番号は無効です。ハイフン(-)を含めてください")
      end
      it 'post_codeが半角のハイフンを含んだ正しい形式でないと登録できない' do
        @address.post_code = '000ー0000'
        @address.valid?
        expect(@address.errors.full_messages).to include("郵便番号は無効です。ハイフン(-)を含めてください")
      end
      it 'phone_numberが全角数字だと登録できない' do
        @address.phone_number = '０８０１２３４５６７８'
        @address.valid?
        expect(@address.errors.full_messages).to include("電話番号は無効です。ハイフン(-)を含めてください")
      end
      it 'tokenが空では登録できない' do
        @address.token = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("Tokenを入力してください")
      end
      it 'user_idが空では登録できない' do
        @address.user_id = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("Userを入力してください")
      end
      it 'item_idが空では登録できない' do
        @address.item_id = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("Itemを入力してください")
      end
    end
  end
end
