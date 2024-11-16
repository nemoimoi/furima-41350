require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item, price: 500)
  end

  describe '商品出品' do
    context '商品出品できる場合' do
      it 'image、title、description、category、condition、postage、area、deadline、priceが存在すれば出品できる。' do
        expect(@item).to be_valid
      end
    end

    context '出品できない場合' do
      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'ユーザーが紐づいていなければ投稿できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end

      it 'titleが空では投稿できない' do
        @item.title = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Title can't be blank")
      end

      it 'descriptionが空では投稿できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーに「---」が選択されている場合は出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it '商品の状態に「---」が選択されている場合は出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end

      it '配送料の負担に「---」が選択されている場合は出品できない' do
        @item.postage_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage can't be blank")
      end

      it '発送元の地域に「---」が選択されている場合は出品できない' do
        @item.area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Area can't be blank")
      end

      it '発送までの日数に「---」が選択されている場合は出品できない' do
        @item.deadline_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Deadline can't be blank")
      end

      it '価格が空では出品できない' do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it '価格に半角数字以外が含まれている場合は出品できない' do
        @item.fake_price = "Test123"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't contain anything other than half-width numbers.")
      end

      it '価格が300円未満では出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end

      it '価格が9_999_999円を超えると出品できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
    end
  end
end