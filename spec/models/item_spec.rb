require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
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

      it 'categoryが選択されないと投稿できない' do
        @item.category = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      
      it 'conditionが選択されないと投稿できない' do
        @item.condition = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end

      it 'postageが選択されないと投稿できない' do
        @item.postage = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage can't be blank")
      end

      it 'areaが選択されないと投稿できない' do
        @item.area = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Area can't be blank")
      end

      it 'deadlineが選択されないと投稿できない' do
        @item.deadline = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Deadline can't be blank")
      end

      it 'priceには¥300~¥9,999,999の半角数字を使用しないと投稿できない' do
        @item.price = "Test123"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price には¥300~¥9,999,999の半角数字を使用してください")
      end
    end
  end
end
