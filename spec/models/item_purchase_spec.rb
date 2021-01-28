require 'rails_helper'

RSpec.describe ItemPurchase, type: :model do
  before do
    @address = FactoryBot.build(:item_purchase)
  end
  
  describe '商品購入での住所情報' do
    context '住所登録できるとき' do
      # 8要素 = :purchase_id, :post_code, :prefecture_id, :city, :address_number, :building, :phone_number
      it '8要素とtokenが存在すれば登録できる' do
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
        expect(@address.errors.full_messages).to include("Post code can't be blank", "Post code is invalid. Include hyphen(-)")
      end
      it 'cityが空では登録できない' do
        @address.city = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("City can't be blank", "City is invalid. Input full-width characters.")
      end
      it 'address_numberが空では登録できない' do
        @address.address_number = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("Address number can't be blank",
                    "Address number is invalid. Input full-width characters.")
      end
      it 'phone_numberが9文字以下では登録できない' do
        @address.phone_number = '090123456'
        @address.valid?
        expect(@address.errors.full_messages).to include("Phone number is invalid. Include hyphen(-)")
      end
      it 'phone_numberが12文字以上では登録できない' do
        @address.phone_number = '080123456789'
        @address.valid?
        expect(@address.errors.full_messages).to include("Phone number is invalid. Include hyphen(-)")
      end
      it 'prefecture_idが1では登録できない' do
        @address.prefecture_id = 1
        @address.valid?
        expect(@address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'phone_numberが空では登録できない' do
        @address.phone_number = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("Phone number can't be blank",
                    "Phone number is invalid. Include hyphen(-)")
      end
      it 'post_codeが半角のハイフンを含んだ正しい形式でないと登録できない' do
        @address.post_code = '000ー0000'
        @address.valid?
        expect(@address.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end
      it 'cityが全角日本語以外では登録できない' do
        @address.city = "1a市でス"
        @address.valid?
        expect(@address.errors.full_messages).to include("City is invalid. Input full-width characters.")
      end
      it 'address_numberが全角日本語以外では登録できない' do
        @address.address_number = "1a番地でス"
        @address.valid?
        expect(@address.errors.full_messages).to include("Address number is invalid. Input full-width characters.")
      end
      it 'phone_numberが全角数字だと登録できない' do
        @address.phone_number = '０８０１２３４５６７８'
        @address.valid?
        expect(@address.errors.full_messages).to include("Phone number is invalid. Include hyphen(-)")
      end
      it 'tokenが空では登録できない' do
        @address.token = nil
        @address.valid?
        expect(@address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
  
end
