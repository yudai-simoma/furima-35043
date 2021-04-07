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
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it 'product_descriptionが空では保存できないこと' do
        @item.product_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      it 'category_idの値が1だど保存できないこと' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーは、--以外を選択して下さい')
      end
      it 'status_idの値が1だど保存できないこと' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態は、--以外を選択して下さい')
      end
      it 'ship_base_idの値が1だど保存できないこと' do
        @item.ship_base_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担は、--以外を選択して下さい')
      end
      it 'prefecture_idの値が1だど保存できないこと' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域は、--以外を選択して下さい')
      end
      it 'ship_date_idの値が1だど保存できないこと' do
        @item.ship_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数は、--以外を選択して下さい')
      end
      it 'priceが空では保存できないこと' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格を入力してください")
      end
      it 'priceが半角英字であれば保存できないこと' do
        @item.price = 'aaa'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は、300円から9,999,999円までで入力して下さい')
      end
      it 'priceが全角英字であれば保存できないこと' do
        @item.price = 'ａａａ'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は、300円から9,999,999円までで入力して下さい')
      end
      it 'priceが全角数字であれば保存できないこと' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は、300円から9,999,999円までで入力して下さい')
      end
      it 'priceの値が299円以下では出品できないこと' do
        @item.price = 200
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は、300円から9,999,999円までで入力して下さい')
      end
      it 'priceの値が10,000,000円以上では出品できないこと' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は、300円から9,999,999円までで入力して下さい')
      end
      it 'imageが空では保存できないこと' do
        @item.images = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
    end
  end
end
