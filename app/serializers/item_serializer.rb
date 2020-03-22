class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :merchant_id, :unit_price

  attributes :unit_price do |obj|
    if obj.unit_price.to_f > 99.99 
      obj.unit_price.fdiv(100.0).to_s
    else obj.unit_price.to_f > 9.99 
      obj.unit_price.fdiv(1.0).round(1).to_s
    end
  end 

  belongs_to :merchant
end 
