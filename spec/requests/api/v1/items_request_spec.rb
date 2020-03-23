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

    it "can create a item" do
      item_params = {name: "remote", description: "Universal Remote", unit_price: "8.01", merchant_id: @merchant_1.id}
     
      post "/api/v1/items", params: {item: item_params}
    
      item_obj = Item.last

      item = JSON.parse(response.body)["data"]
  
      expect(response).to be_successful
      expect(item['attributes']['name']).to eq(item_params[:name])
      expect(item['attributes']['description']).to eq(item_params[:description])
      expect(item['attributes']['unit_price']).to eq(item_params[:unit_price])
      expect(item['attributes']['merchant_id']).to eq(item_params[:merchant_id])
    end

    it "can update a item" do
      @name = @item_1.name
      @description = @item_1.description
      @unit_price = @item_1.unit_price

      item_params = {name: "Razor", description: "New discription", unit_price: 10.00 }

      put "/api/v1/items/#{@item_1.id}", params: {item: item_params}
    
      item_obj = Item.last

      item = JSON.parse(response.body)["data"]
  
      expect(response).to be_successful
      expect(item['attributes']['name']).to eq(item_params[:name])
      expect(item['attributes']['name']).to_not eq(@name)
      expect(item['attributes']['description']).to eq(item_params[:description])
      expect(item['attributes']['description']).to_not eq(@description)
      expect(item['attributes']['unit_price']).to eq(item_params[:unit_price].to_s)
      expect(item['attributes']['unit_price']).to_not eq(@unit_price)
    end

    it "can delete a Item" do

      expect(Item.count).to eq(4)  
      
      delete "/api/v1/items/#{@item_1.id}"
      
      get '/api/v1/items' 

      items = JSON.parse(response.body)["data"]
      
      expect(response).to be_successful
      expect(Item.count).to eq(3)  
      expect{Item.find(@item_1.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'can find the specific merchant for that item' do

      get "/api/v1/items/#{@item_1.id}/merchant"

      merchant = JSON.parse(response.body)['data']

      expect(response).to be_successful

      expect(merchant['id']).to eq(@merchant_1.id.to_s)
      expect(merchant['id']).to_not eq(@merchant_2.id.to_s)
    end
  end 
end 