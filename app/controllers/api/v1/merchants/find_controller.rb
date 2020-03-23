class Api::V1::Merchants::FindController < ApplicationController
  def index 
    render json: MerchantSerializer.new(Merchant.find_by(merch_params))
  end 

  private
    def merch_params
      params.permit(:id, :name, :created_at, :updated_at)
    end
end 