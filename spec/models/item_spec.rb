require 'rails_helper'
RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe 'ユーザー新規登録' do
    context '商品登録できるとき' do
      # 8要素 = name, detail, condition_id, fee_burdened_id, prefecture_id, shipping_date_id, category_id, price
      it '8要素が存在すれば登録できる' do
        expect(@item).to be_valid
      end
      it 'nameが40文字以下であれば登録できる' do
        @item.name = "a"
        expect(@item).to be_valid
      end
      it 'detailが1000文字以下であれば登録できる' do
        @item.detail = "丸"
        expect(@item).to be_valid
      end
      it 'priceが300円以上であれば登録できる' do
        @item.price = 300
        expect(@item).to be_valid
      end
      it 'priceが9999999円以下であれば登録できる' do
        @item.price = 9999999
        expect(@item).to be_valid
      end
    end
    context '商品登録できないとき' do
      it 'nameが空では登録できない' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'nameが41文字以上では登録できない' do
        @item.name = Faker::Lorem.characters(number: 41)
        @item.valid?
        expect(@item.errors.full_messages).to include("Name is too long (maximum is 40 characters)")
      end
      it 'detailが空では登録できない' do
        @item.detail = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Detail can't be blank")
      end
      it 'detailが1001文字以上では登録できない' do
        @item.detail = Faker::Lorem.characters(number: 1001)
        @item.valid?
        expect(@item.errors.full_messages).to include("Detail is too long (maximum is 1000 characters)")
      end
      it 'priceが空では登録できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが299円以下では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than 299")
      end
      it 'priceが10000000円以上では登録できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than 10000000")
      end
      it 'condition_idが1では登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition must be other than 1")
      end
      it 'fee_burdened_idが1では登録できない' do
        @item.fee_burdened_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Fee burdened must be other than 1")
      end
      it 'prefecture_idが1では登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it 'shipping_date_idが1では登録できない' do
        @item.shipping_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping date must be other than 1")
      end
      it 'category_idが1では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'priceが半角数字以外は登録できない' do
        @item.price = "aaa"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
    end
  end
end
