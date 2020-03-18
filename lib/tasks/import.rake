require 'csv'

desc "import csv data" 
  task :import => [:environment] do
    file = "./db/rails_data/customers.csv"
    CSV.foreach(file, headers: true) do |row|
      customer_hash = row.to_hash
      customer = Customer.create(customer_hash)
    end
    puts "created #{Customer.count} customers!"
  end 

  task :import => [:environment] do
    file = "./db/rails_data/merchants.csv"
    CSV.foreach(file, headers: true) do |row|
      merchant_hash = row.to_hash
      merchant = Merchant.create(merchant_hash)
    end
    puts "created #{Merchant.count} merchants!"
  end 
