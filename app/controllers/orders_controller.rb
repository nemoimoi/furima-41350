class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_if_sold_out, only: [:index, :create]
  before_action :redirect_if_not_authorized, only: [:index, :create]

  def index
    gon.payjp_public_key = ENV["PAYJP_PUBLIC_KEY"]
    Rails.logger.debug { "Gon Public Key: #{gon.payjp_public_key}" }
    @order_destination = OrderDestination.new
  end


  def create
    @order_destination = OrderDestination.new(order_destination_params)
    Rails.logger.debug { "OrderDestination Params: #{order_destination_params.inspect}" }

    if @order_destination.valid?
      pay_item
      @order_destination.save
      redirect_to root_path, notice: 'Order was successfully created.'
    else
      Rails.logger.debug { "Validation Errors: #{@order_destination.errors.full_messages}" }
      gon.payjp_public_key = ENV["PAYJP_PUBLIC_KEY"]
      Rails.logger.debug { "Gon Public Key (create): #{gon.payjp_public_key}" }
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_sold_out
    if @item.sold_out?
      redirect_to root_path
    end
  end

  def redirect_if_not_authorized
    if current_user == @item.user
      redirect_to root_path
    end
  end

  def order_destination_params
    params.require(:order_destination).permit(
      :postcode, :area_id, :municipality,
      :house_number, :building_name, :telephone_number, :token
    ).merge(token: params[:token], item_id: params[:item_id], user_id: current_user.id)
  end

  def order_params
    params.permit(:token)
  end

  def pay_item
    item_id = params[:item_id]
    item = Item.find(item_id)
    item_price = item.price
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
