require 'rails_helper'

RSpec.describe PurchaserAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchaser_address = FactoryBot.build(:purchaser_address, user_id: user.id, item_id: item.id)
    sleep 0.05
  end
  

  describe '商品購入機能' do
    context '商品購入機能がうまくいくとき' do
      it '必要な値が正しく入力されていれば保存できること' do
        expect(@purchaser_address).to be_valid
      end
      it 'postal_codeには3文字、ハイフン、4文字の数値が正しく入力されていれば保存できること' do
        @purchaser_address.postal_code = '321-4321'
        expect(@purchaser_address).to be_valid
      end
      it 'phone_numberは11桁以内の数値が正しく入力されていれば保存できること' do
        @purchaser_address.phone_number = '12345678910'
        expect(@purchaser_address).to be_valid
      end
      it 'building_nameが空でも保存できること' do
        @purchaser_address.building_name = ''
        expect(@purchaser_address).to be_valid
      end
    end

    context '商品購入機能がうまくいかないとき' do
      it 'postal_codeが空では保存できないこと' do
        @purchaser_address.postal_code = ''
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeの値にハイフンが入力されていないと保存できないこと' do
        @purchaser_address.postal_code = '1234567'
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include("Postal code is invalid. Input correctly")
      end
      it 'postal_codeの値に3文字、ハイフン、4文字の半角数値が入力されていないと保存できないこと' do
        @purchaser_address.postal_code = '12-34567'
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include("Postal code is invalid. Input correctly")
      end
      it 'prefecture_idを選択していないと保存できないこと' do
        @purchaser_address.prefecture_id = ''
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空では保存できないこと' do
        @purchaser_address.city = ''
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include("City can't be blank")
      end
      it 'house_numberが空では保存できないこと' do
        @purchaser_address.house_number = ''
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include("House number can't be blank")
      end
      it 'phone_numberが空では保存できないこと' do
        @purchaser_address.phone_number = ''
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberの値が11桁でないと保存できないこと' do
        @purchaser_address.phone_number = '123456789'
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include("Phone number is invalid. Input only number")
      end
      it 'phone_numberの値が全角だとでないと保存できないこと' do
        @purchaser_address.phone_number = '１２３４５６７８９'
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include("Phone number is invalid. Input only number")
      end
      it 'クレジットカード情報が空では保存できないこと' do
        
      end
      it 'userが紐付いていないと保存できないこと' do
        @purchaser_address.user_id = nil
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @purchaser_address.item_id = nil
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
