class ItemsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create]
  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    
    if @item.save
      redirect_to '/'
    else
      render :new ,status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
    @user = @item.user
  end

  private

  def item_params
    params.require(:item).permit(:image, :title, :description, :category_id, :condition_id, :postage_id, :area_id, :deadline_id, :price).merge(user_id: current_user.id)
  end
end
