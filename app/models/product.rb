class Product < ApplicationRecord
    SALES_TAX_RATE = 0.10
    IMPORTED_SALES_TAX_RATE = 0.05
    
    validates :name, presence: true
    validates :price, presence: true
    validates :imported, inclusion: [true, false]
    validates :exempt, inclusion: [true, false]

  # calculates the sales tax which is 10% on all items EXCEPT books, food, medical
  def self.calculate_tax(products)
    taxable_products = products.select {|p| !p.exempt }
    sum = 0
    taxable_products.each{|s| sum = sum + s.calculate_item_tax}
    return sum
  end

  def calculate_item_tax
    (price * SALES_TAX_RATE).round(0.05)
  end
  
  # calculates the import duty which is 5% that is an additional sales tax on items that are imported
  def self.calculate_import(products)
    imported_taxable_products = products.select {|p| p.imported }
    total_price_in_cents = imported_taxable_products.sum { |p| p.price } 
    return total_price_in_cents * IMPORTED_SALES_TAX_RATE
  end
    
  # calculates sum of all taxes where applicable
  def self.calculate_total_price(products)
    products.sum { |p| p.price } + Product.calculate_tax(products) + Product.calculate_import(products)
  end
end
