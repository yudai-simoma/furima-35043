require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品機能がうまくいくとき' do
      it '全ての値が正しく入力されていれば保存できること' do
        expect(@item).to be_valid
      end
      it 'category_idが1以外の数値であれば保存できること' do
        @item.category_id = 2
        expect(@item).to be_valid
      end
      it 'status_idが1以外の数値であれば保存できること' do
        @item.status_id = 2
        expect(@item).to be_valid
      end
      it 'ship_base_idが1以外の数値であれば保存できること' do
        @item.ship_base_id = 2
        expect(@item).to be_valid
      end
      it 'prefecture_idが1以外の数値であれば保存できること' do
        @item.prefecture_id = 2
        expect(@item).to be_valid
      end
      it 'ship_date_idが1以外の数値であれば保存できること' do
        @item.ship_date_id = 2
        expect(@item).to be_valid
      end
      it 'priceが¥300~¥9,999,999の半角数字であれば保存できること' do
        @item.price = 300
        expect(@item).to be_valid
      end
    end

    context '商品出品機能がうまくいかないとき' do
      it 'productが空では保存できないこと' do
        @item.product = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product can't be blank")
      end
      it 'product_descriptionが空では保存できないこと' do
        @item.product_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product description can't be blank")
      end
      it 'category_idを選択していないと保存できないこと' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'category_idの値が1だど保存できないこと' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end
      it 'status_idを選択していないと保存できないこと' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end
      it 'status_idの値が1だど保存できないこと' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Status must be other than 1')
      end
      it 'ship_base_idを選択していないと保存できないこと' do
        @item.ship_base_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Ship base can't be blank")
      end
      it 'ship_base_idの値が1だど保存できないこと' do
        @item.ship_base_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Ship base must be other than 1')
      end
      it 'prefecture_idを選択していないと保存できないこと' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'prefecture_idの値が1だど保存できないこと' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it 'ship_date_idを選択していないと保存できないこと' do
        @item.ship_date_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Ship date can't be blank")
      end
      it 'ship_date_idの値が1だど保存できないこと' do
        @item.ship_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Ship date must be other than 1')
      end
      it 'priceが空では保存できないこと' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが半角英字であれば保存できないこと' do
        @item.price = 'aaa'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is invalid. Input 300 ~ 9,999,999 numerical value. ')
      end
      it 'priceが全角英字であれば保存できないこと' do
        @item.price = 'ａａａ'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is invalid. Input 300 ~ 9,999,999 numerical value. ')
      end
      it 'priceが全角数字であれば保存できないこと' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is invalid. Input 300 ~ 9,999,999 numerical value. ')
      end
      it 'priceの値が299円以下では出品できないこと' do
        @item.price = 200
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is invalid. Input 300 ~ 9,999,999 numerical value. ')
      end
      it 'priceの値が10,000,000円以上では出品できないこと' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is invalid. Input 300 ~ 9,999,999 numerical value. ')
      end
      it 'imageが空では保存できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
    end
  end
end
