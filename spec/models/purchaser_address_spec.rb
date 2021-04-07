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
        expect(@purchaser_address.errors.full_messages).to include("郵便番号を入力してください")
      end
      it 'postal_codeの値にハイフンが入力されていないと保存できないこと' do
        @purchaser_address.postal_code = '1234567'
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include("郵便番号はハイフンを入れ入力して下さい")
      end
      it 'postal_codeの値に3文字、ハイフン、4文字の半角数値が入力されていないと保存できないこと' do
        @purchaser_address.postal_code = '12-34567'
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include("郵便番号はハイフンを入れ入力して下さい")
      end
      it 'prefecture_idの値が1だど保存できないこと' do
        @purchaser_address.prefecture_id = 1
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include("都道府県は、--以外を選択して下さい")
      end
      it 'cityが空では保存できないこと' do
        @purchaser_address.city = ''
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'house_numberが空では保存できないこと' do
        @purchaser_address.house_number = ''
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include("番地を入力してください")
      end
      it 'phone_numberが空では保存できないこと' do
        @purchaser_address.phone_number = ''
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'phone_numberの値が10桁未満だと保存できないこと' do
        @purchaser_address.phone_number = '123456789'
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include("電話番号は10桁または11桁の値を入力して下さい")
      end
      it 'phone_numberの値が12桁以上だと保存できないこと' do
        @purchaser_address.phone_number = '1234567891112'
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include("電話番号は10桁または11桁の値を入力して下さい")
      end
      it 'phone_numberの値が全角だと保存できないこと' do
        @purchaser_address.phone_number = '１２３４５６７８９'
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include("電話番号は10桁または11桁の値を入力して下さい")
      end
      it 'phone_numberの値が英数字混合では保存できないこと' do
        @purchaser_address.phone_number = 'abcde123456'
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include("電話番号は10桁または11桁の値を入力して下さい")
      end
      it 'tokenが空では登録できないこと' do
        @purchaser_address.token = nil
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
      it 'userが紐付いていないと保存できないこと' do
        @purchaser_address.user_id = nil
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include("Userを入力してください")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @purchaser_address.item_id = nil
        @purchaser_address.valid?
        expect(@purchaser_address.errors.full_messages).to include("Itemを入力してください")
      end
    end
  end
end
