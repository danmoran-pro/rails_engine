require 'rails_helper'

describe "Invoice API" do
  describe "can send data" do
    before :each do 
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)

      @customer_1 = create(:customer)
      @customer_2 = create(:customer)

      @invoice_1 = create(:invoice, merchant_id: @merchant_1.id, customer_id: @customer_1.id)
      @invoice_2 = create(:invoice, merchant_id: @merchant_2.id, customer_id: @customer_2.id)
    end 
    it "sends a list of invoice" do
      
      get '/api/v1/invoices'
      
      expect(response).to be_successful
      
      invoice = JSON.parse(response.body)["data"]
      
      expect(invoice.count).to eql(2)
    end
    it "sends a unique item" do
      
      get "/api/v1/invoices/#{@invoice_1.id}"
      
      expect(response).to be_successful
      invoice = JSON.parse(response.body)["data"]
      
      expect(invoice['attributes']['id']).to eq(@invoice_1.id)
      expect(invoice['attributes']['id']).not_to eq(@invoice_2.id)
      expect(invoice['attributes']['merchant_id']).to eq(@merchant_1.id)
      expect(invoice['attributes']['merchant_id']).to_not eq(@merchant_2.id)
      expect(invoice['attributes']['customer_id']).to eq(@customer_1.id)
      expect(invoice['attributes']['customer_id']).to_not eq(@customer_2.id)
    end
  end 
end 