require 'rails_helper'

RSpec.describe OrderDestination, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_destination = FactoryBot.build(:order_destination, user_id: @user.id, item_id: @item.id) 
  end
  describe '送付先情報の保存' do

    context '内容に問題ない場合' do
      it '全ての値が正しく入力されていれば保存できること' do
        expect(@order_destination).to be_valid
      end
      it '建物名以外の値が正しく入力されていれば保存できること' do
        @order_destination.building_name = ''
        expect(@order_destination).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postcodeが空だと保存できないこと' do
        @order_destination.postcode = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Postcode can't be blank")
      end
      it 'postcodeが半角ハイフンを含む形でなければ保存できないこと' do
        @order_destination.postcode = "1234567"
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Postcode is invalid. Include hyphen(-)")
      end
      it 'area_idが空だと保存できないこと' do
        @order_destination.area_id = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Area can't be blank")
      end
      it 'municipalityが空だと保存できないこと' do
        @order_destination.municipality = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Municipality can't be blank")
      end
      it 'house_numberが空だと保存できないこと' do
        @order_destination.house_number = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("House number can't be blank")
      end
      it 'telephone_numberが空だと保存できないこと' do
        @order_destination.telephone_number = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Telephone number can't be blank")
      end
      it 'telephone_numberが10桁未満は保存できないこと' do
        @order_destination.telephone_number = '123456789'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Telephone number is invalid. Include only numbers")
      end
      it 'telephone_numberが12桁以上では登録できないこと' do
        @order_destination.telephone_number = '123456789123'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Telephone number is invalid. Include only numbers")
      end
      it '電話番号に数字以外が含まれると登録できないこと' do
        @order_destination.telephone_number = 't1234567890'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Telephone number is invalid. Include only numbers")
      end
      it 'tokenが空だと保存できないこと' do
        @order_destination.token = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Token can't be blank")
      end

      it 'user_idが空だと保存できないこと' do
        @order_destination.user_id = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空だと保存できないこと' do
        @order_destination.item_id = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
