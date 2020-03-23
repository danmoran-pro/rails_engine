require 'rails_helper'

describe "Merchant API" do
  describe "can send data" do
    before :each do 
      create_list(:merchant, 3)
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)

      @item_1 = create(:item, merchant: @merchant_1)
      @item_2 = create(:item, merchant: @merchant_1)
      @item_3 = create(:item, merchant: @merchant_2)
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

      expect(merchant['id']).to eq(@merchant_1.id.to_s)
      expect(merchant['id']).not_to eq(@merchant_2.id.to_s)
    end

    it "can create a merchant" do
      merchant_params = {name: "Remote store"}
     
      post "/api/v1/merchants", params: {merchant: merchant_params}
    
      merchant_obj = Merchant.last

      merchant = JSON.parse(response.body)["data"]
  
      expect(response).to be_successful
      expect(merchant['attributes']['name']).to eq(merchant_params[:name])
    end

    it "can update a merchant" do
      @name = @merchant_1.name
      merchant_params = {name: "Comb Store"}

      put "/api/v1/merchants/#{@merchant_1.id}", params: {merchant: merchant_params}
    
      merchant_obj = Merchant.last

      merchant = JSON.parse(response.body)["data"]
  
      expect(response).to be_successful
      expect(merchant['attributes']['name']).to eq(merchant_params[:name])
      expect(merchant['attributes']['name']).to_not eq(@name)
    end

    it "can delete a merchant" do

      expect(Merchant.count).to eq(5)  
      
      delete "/api/v1/merchants/#{@merchant_1.id}"
      
      get '/api/v1/merchants' 

      merchants = JSON.parse(response.body)["data"]
      
      expect(response).to be_successful
      expect(Merchant.count).to eq(4)  
      expect{Item.find(@merchant_1.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'can find all items from a specific merchant' do

      get "/api/v1/merchants/#{@merchant_1.id}/items"

      items = JSON.parse(response.body)['data']

      expect(response).to be_successful

      expect(items.count).to eql(2)
      expect(items.first['attributes']['merchant_id']).to_not be eql(@merchant_2.id)
      expect(items.last['attributes']['merchant_id']).to_not be eql(@merchant_2.id)
    end

    it 'can find a merchant by name' do

      get "/api/v1/merchants/find?name=#{@merchant_1.name}"

      merchant = JSON.parse(response.body)['data']

      expect(response).to be_successful

      expect(merchant['attributes']["name"]).to eq(@merchant_1.name)
      expect(merchant['attributes']["name"]).to_not eq(@merchant_2.name)
    end
    # it 'can find a merchant by partial name' do
    #   @merch_1 = create(:merchant, name: "Turing")
    #   @merch_2 = create(:merchant, name: "Ring")

    #   get "/api/v1/merchants/find?name=ring"

    #   merchant = JSON.parse(response.body)['data']

    #   expect(response).to be_successful
      
    #   expect(merchant['attributes']["name"]).to eq(@merch_1.name)
    #   expect(merchant['attributes']["name"]).to eq(@merch_2.name)
    # end
  end 
end 