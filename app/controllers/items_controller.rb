class ItemsController < ApplicationController
  before_action :authenticate_user!, only:[:edit, :new, :create, :destroy]
  before_action :item_find, only:[:show, :edit, :update, :destroy]
  before_action :match_id, only:[:edit, :destroy]
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
    @user = @item.user
  end

  def edit
    set_item_collections
  end

  def update
    if @item.update(item_params)
       redirect_to item_path
    else
      set_item_collections
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :title, :description, :category_id, :condition_id, :postage_id, :area_id, :deadline_id, :price).merge(user_id: current_user.id)
  end

  def set_item_collections
    @categories = Category.all
    @conditions = Condition.all
    @postages = Postage.all
    @areas = Area.all
    @deadlines = Deadline.all
  end

  def item_find
    @item = Item.find(params[:id])
  end

  def match_id
    unless current_user.id == @item.user_id
      redirect_to root_path
    end
  end
end
