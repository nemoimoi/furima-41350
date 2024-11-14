class ItemsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create]
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    
    if @item.save
      Rails.logger.debug("Item saved successfully.")
      redirect_to '/'
    else
      puts @item.errors.full_messages
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :title, :description, :category_id, :condition_id, :postage_id, :area_id, :deadline_id, :price, :user_id )
  end
end
