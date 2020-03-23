class Api::V1::ItemsController < ApplicationController

  def index 
    render json: ItemSerializer.new(Item.all)
  end 

  def show 
    render json: ItemSerializer.new(Item.find(params["id"]))
  end 

  def create 
    merchant = Merchant.find(params[:item][:merchant_id])
    render json: ItemSerializer.new(merchant.items.create(item_params))
  end 

  def update
    render json:ItemSerializer.new(Item.update(params["id"],item_params))
  end 

  def destroy 
    render json: ItemSerializer.new(Item.destroy(params["id"]))
  end 

  private
    def item_params
      params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end
end
