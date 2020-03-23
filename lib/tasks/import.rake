require 'csv'

desc "import csv data" 
  task :import => [:environment] do
    Customer.destroy_all
    file = "./db/rails_data/customers.csv"
    CSV.foreach(file, headers: true) do |row|
      customer_hash = row.to_hash
      customer = Customer.create(customer_hash)
    end
    puts "created #{Customer.count} customers!"
  end 

  task :import => [:environment] do
    Merchant.destroy_all
    file = "./db/rails_data/merchants.csv"
    CSV.foreach(file, headers: true) do |row|
      merchant_hash = row.to_hash
      merchant = Merchant.create(merchant_hash)
    end
    puts "created #{Merchant.count} merchants!"
  end 

  task :import => [:environment] do
    file = "./db/rails_data/invoices.csv"
    Invoice.destroy_all
    CSV.foreach(file, headers: true) do |row|
      invoice_hash = row.to_hash
      invoice = Invoice.create(invoice_hash)
    end
    puts "created #{Invoice.count} invoices!"
  end 

  task :import => [:environment] do
    file = "./db/rails_data/items.csv"
    Item.destroy_all
    CSV.foreach(file, headers: true) do |row|
      Item.create!({
        id: row['id'],
        name: row['name'],
        description: row['description'],
        unit_price: row['unit_price'].to_f/100,
        merchant_id: row['merchant_id'],
        created_at: row['created_at'],
        updated_at: row['updated_at']
      })
    end
    puts "created #{Item.count} items!"
  end 

  task :import => [:environment] do
    file = "./db/rails_data/invoice_items.csv"
    InvoiceItem.destroy_all

    CSV.foreach(file, headers: true) do |row|
      InvoiceItem.create!({
        id: row['id'],
        item_id: row['item_id'],
        invoice_id: row['invoice_id'],
        unit_price: row['unit_price'].to_f/100,
        quantity: row['quantity'],
        created_at: row['created_at'],
        updated_at: row['updated_at'],
      })
    end
    puts "created #{InvoiceItem.count} invoice items!"
  end 

  task :import => [:environment] do
    file = "./db/rails_data/transactions.csv"
    Transaction.destroy_all
    CSV.foreach(file, headers: true) do |row|
      transactions_hash = row.to_hash
      transactions = Transaction.create(transactions_hash)
    end
    puts "created #{Transaction.count} transactions!"
  end 
