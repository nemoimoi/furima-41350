require 'rails_helper'

RSpec.describe OrderDestination, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_destination = FactoryBot.build(:order_destination) 
  end
  describe '送付先情報の保存' do

    context '内容に問題ない場合' do
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
      it 'postcodeが「3桁ハイフン4桁」の半角文字列以外では保存できないこと' do
        invalid_postcodes = ['1234567', '12-34567', '123-456', 'abcdefg']
        invalid_postcodes.each do |invalid_postcode|
          @order_destination.postcode = invalid_postcode
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("Postcode is invalid. Include hyphen(-)")
        end
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
      it 'telephone_numberが10桁以上11桁以内の半角数値以外では保存できないこと' do
        invalid_numbers = ["123456789", "123456789012", "1234abc567", "123-456-7890", "１２３４５６７８９０"]
        invalid_numbers.each do |invalid_number|
          @order_destination.telephone_number = invalid_number
          @order_destination.valid?
          expect(@order_destination.errors.full_messages).to include("Telephone number is invalid. Include only numbers")
        end
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
