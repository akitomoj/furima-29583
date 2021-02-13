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
        @item.name = 'a'
        expect(@item).to be_valid
      end
      it 'detailが1000文字以下であれば登録できる' do
        @item.detail = '丸'
        expect(@item).to be_valid
      end
      it 'priceが300円以上であれば登録できる' do
        @item.price = 300
        expect(@item).to be_valid
      end
      it 'priceが9999999円以下であれば登録できる' do
        @item.price = 9_999_999
        expect(@item).to be_valid
      end
    end
    context '商品登録できないとき' do
      it 'nameが空では登録できない' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it 'nameが41文字以上では登録できない' do
        @item.name = Faker::Lorem.characters(number: 41)
        @item.valid?
        expect(@item.errors.full_messages).to include('商品名は40文字以内で入力してください')
      end
      it 'detailが空では登録できない' do
        @item.detail = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      it 'detailが1001文字以上では登録できない' do
        @item.detail = Faker::Lorem.characters(number: 1001)
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の説明は1000文字以内で入力してください')
      end
      it 'priceが空では登録できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格を入力してください", "販売価格は数値で入力してください")
      end
      it 'priceが299円以下では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は299より大きい値にしてください')
      end
      it 'priceが10000000円以上では登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は10000000より小さい値にしてください')
      end
      it 'condition_idが1では登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態は1以外の値にしてください')
      end
      it 'fee_burdened_idが1では登録できない' do
        @item.fee_burdened_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担は1以外の値にしてください')
      end
      it 'prefecture_idが1では登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域は1以外の値にしてください')
      end
      it 'shipping_date_idが1では登録できない' do
        @item.shipping_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数は1以外の値にしてください')
      end
      it 'category_idが1では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーは1以外の値にしてください')
      end
      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("出品画像を入力してください")
      end
      it 'priceが半角数字以外は登録できない' do
        @item.price = 'aaa'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は数値で入力してください')
      end
    end
  end
end
