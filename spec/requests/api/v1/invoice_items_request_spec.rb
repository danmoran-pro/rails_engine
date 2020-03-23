require 'rails_helper'

describe "InvoiceItems API" do
  describe "can send data" do
    before :each do 
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)

      @customer_1 = create(:customer)
      @customer_2 = create(:customer)


      @item_1 = create(:item, merchant: @merchant_1)
      @item_2 = create(:item, merchant: @merchant_1)

      @invoice_1 = create(:invoice, merchant_id: @merchant_1.id, customer_id: @customer_1.id)
      @invoice_2 = create(:invoice, merchant_id: @merchant_2.id, customer_id: @customer_2.id)

      @invoice_item_1 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_1.id)
      @invoice_item_2 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_2.id)

      create_list(:invoice_item, 5, invoice_id: @invoice_1.id, item_id: @item_1.id)
      create_list(:invoice_item, 5, invoice_id: @invoice_2.id, item_id: @item_2.id)
    end 
    it "sends a list of invoice_items" do
      
      get '/api/v1/invoice_items'
      
      expect(response).to be_successful
      
      invoice_items = JSON.parse(response.body)["data"]
      
      expect(invoice_items.count).to eql(12)
    end
    it "sends a unique invoice_item" do
      
      get "/api/v1/invoice_items/#{@invoice_item_1.id}"
      
      expect(response).to be_successful
      
      invoice_item = JSON.parse(response.body)["data"]

      expect(invoice_item['attributes']['id']).to eq(@invoice_item_1.id)
      expect(invoice_item['attributes']['id']).not_to eq(@invoice_item_2.id)
      expect(invoice_item['attributes']['invoice_id']).to eq(@invoice_1.id)
      expect(invoice_item['attributes']['invoice_id']).to_not eq(@invoice_2.id)
      expect(invoice_item['attributes']['item_id']).to eq(@item_1.id)
      expect(invoice_item['attributes']['item_id']).to_not eq(@item_2.id)
    end
  end 
end 