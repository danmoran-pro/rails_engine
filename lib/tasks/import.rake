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
