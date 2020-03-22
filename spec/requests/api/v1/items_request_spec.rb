require 'rails_helper'

describe "Items API" do
  describe "can send data" do
    before :each do 
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1)
      @item_2 = create(:item, merchant: @merchant_1)
      @item_3 = create(:item, merchant: @merchant_2)
      @item_5 = create(:item, merchant_id: @merchant_2.id)
    end 
    it "sends a list of items" do
      
      get '/api/v1/items'
      
      expect(response).to be_successful
      
      items = JSON.parse(response.body)["data"]
      
      expect(items.count).to eql(4)
    end
    it "sends a unique item" do
      
      get "/api/v1/items/#{@item_5.id}"
      
      expect(response).to be_successful
      item = JSON.parse(response.body)["data"]
      
      expect(item['attributes']['id']).to eq(@item_5.id)
      expect(item['attributes']['id']).not_to eq(@item_1.id)
      expect(item['attributes']['merchant_id']).to eq(@merchant_2.id)
      expect(item['attributes']['merchant_id']).to_not eq(@merchant_1.id)
    end
  end 
end 