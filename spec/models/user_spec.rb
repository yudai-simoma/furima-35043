require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it 'nicknameとemail、passwordとpassword_confirmationとlast_nameとfirst_nameとlast_name_kanaとfirst_name_kanaとbirthday_dateが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上の半角英数字あれば登録できる' do
        @user.password = 'aaa000'
        @user.password_confirmation = 'aaa000'
        expect(@user).to be_valid
      end
      it 'last_nameが全角であれば登録できる' do
        @user.last_name = '達也'
        expect(@user).to be_valid
      end
      it 'first_nameが全角であれば登録できる' do
        @user.last_name = '佐藤'
        expect(@user).to be_valid
      end
      it 'last_name_kanaが全角（カタカナ）であれば登録できる' do
        @user.last_name = 'サトウ'
        expect(@user).to be_valid
      end
      it 'first_name_kanaが全角（カタカナ）であれば登録できる' do
        @user.last_name = 'タツヤ'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'emailに@が含まれていないと登録できない' do
        @user.email = 'aaa111.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'aa345'
        @user.password_confirmation = 'aa345'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password = 'aa1234'
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'passwordとpassword_confirmationの値が異なると登録できない' do
        @user.password = 'aa1234'
        @user.password_confirmation = 'aa12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'passwordは半角英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは文字と数字の両方を含めて下さい')
      end
      it 'passwordは半角数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは文字と数字の両方を含めて下さい')
      end
      it 'passwordは全角英数字のみでは登録できない' do
        @user.password = 'ａａ１１１１'
        @user.password_confirmation = 'ａａ１１１１'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは文字と数字の両方を含めて下さい')
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字を入力してください')
      end
      it 'last_nameが半角では登録できない' do
        @user.last_name = 'ﾃｽﾄ'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字が不適切です。全角で入力して下さい')
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end
      it 'first_nameが半角では登録できない' do
        @user.first_name = 'ﾃｽﾄ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前が不適切です。全角で入力して下さい')
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字（カタカナ）を入力してください")
      end
      it 'last_name_kanaが全角（カタカナ）以外では登録できない' do
        @user.last_name_kana = 'ﾃｽﾄ'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字（カタカナ）が不適切です。全角カタカナ文字で入力して下さい')
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（カタカナ）を入力してください")
      end
      it 'first_name_kanaが全角（カタカナ）以外では登録できない' do
        @user.first_name_kana = 'ﾃｽﾄ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前（カタカナ）が不適切です。全角カタカナ文字で入力して下さい')
      end
      it 'birthday_dateが空では登録できない' do
        @user.birthday_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
