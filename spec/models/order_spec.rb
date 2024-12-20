require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = FactoryBot.build(:order)
  end

  context '内容に問題ない場合' do
    it "tokenがあれば保存できること" do
      expect(@order).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it "tokenが空では保存ができないこと" do
      @order.token = ''
      @order.valid?
      expect(@order.errors.full_messages).to include("Token can't be blank")
    end
  end

end
