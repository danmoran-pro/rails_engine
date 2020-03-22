require 'rails_helper'

describe "Customer API" do
  describe "can send data" do
    before :each do 
      create_list(:customer, 3)
      @customer_1 = create(:customer)
      @customer_2 = create(:customer, first_name: "Danny", last_name: "Moran")
    end 
    it "sends a list of customers" do
      
      get '/api/v1/customers'
      
      expect(response).to be_successful
      
      customers = JSON.parse(response.body)["data"]
      expect(customers.count).to eql(5)
    end
    
    it "sends a unique customer" do
      
      get "/api/v1/customers/#{@customer_1.id}"
      
      expect(response).to be_successful
      
      customer = JSON.parse(response.body)["data"]
      expect(customer['attributes']['id']).to eq(@customer_1.id)
      expect(customer['attributes']['id']).not_to eq(@customer_2.id)
    end
  end
end
 
