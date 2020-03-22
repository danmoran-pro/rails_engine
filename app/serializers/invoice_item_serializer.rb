class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :quantity, :invoice_id, :item_id

  attributes :unit_price do |obj| 
    obj.unit_price.fdiv(100.0).to_s
  end 
  belongs_to :invoice
  belongs_to :item
end 
