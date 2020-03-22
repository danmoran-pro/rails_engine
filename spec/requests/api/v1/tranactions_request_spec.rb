require 'rails_helper'

describe "Transactions API" do
  describe "can send data" do
    before :each do 
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)

      @customer_1 = create(:customer)
      @customer_2 = create(:customer)

      @invoice_1 = create(:invoice, merchant_id: @merchant_1.id, customer_id: @customer_1.id)
      @invoice_2 = create(:invoice, merchant_id: @merchant_2.id, customer_id: @customer_2.id)

      @transaction_1 = create(:transaction, invoice_id: @invoice_1.id)
      @transaction_2 = create(:transaction, invoice_id: @invoice_2.id)
    end 
    it "sends a list of transactions" do
      
      get '/api/v1/transactions'
      
      expect(response).to be_successful
      
      transactions = JSON.parse(response.body)["data"]
      
      expect(transactions.count).to eql(2)
    end
    it "sends a unique transaction" do
      
      get "/api/v1/transactions/#{@transaction_1.id}"
      
      expect(response).to be_successful
      transaction = JSON.parse(response.body)["data"]
      
      expect(transaction['attributes']['id']).to eq(@transaction_1.id)
      expect(transaction['attributes']['id']).not_to eq(@transaction_2.id)
      expect(transaction['attributes']['invoice_id']).to eq(@invoice_1.id)
      expect(transaction['attributes']['invoice_id']).to_not eq(@invoice_2.id)
    end
  end 
end 