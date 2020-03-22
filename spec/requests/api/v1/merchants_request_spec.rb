require 'rails_helper'

describe "Merchant API" do
  describe "can send data" do
    before :each do 
      create_list(:merchant, 3)
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
    end 
    it "sends a list of merchants" do
      
      get '/api/v1/merchants'
      
      expect(response).to be_successful
      
      merchants = JSON.parse(response.body)["data"]
      expect(merchants.count).to eql(5)
    end
    it "sends a unique merchant" do
      
      get "/api/v1/merchants/#{@merchant_1.id}"
      
      expect(response).to be_successful
      merchant = JSON.parse(response.body)["data"]
      expect(merchant['attributes']['id']).to eq(@merchant_1.id)
      expect(merchant['attributes']['id']).not_to eq(@merchant_2.id)
    end
  end 
end 