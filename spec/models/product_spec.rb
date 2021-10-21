# spec/models/product.rb

require 'rails_helper'

RSpec.describe Product, :type => :model do
  it "is not valid" do
    p = Product.new(name: "Great Gatsby", price: 1099, imported: true, exempt: nil)
    expect(p).to_not be_valid
  end

  it "is valid" do
    p = Product.new(name: "Great Gatsby", price: 1099, imported: true, exempt: false)
    expect(p).to be_valid
  end

  it "calculate_item_tax" do
    p = Product.new(name: "Great Gatsby", price: 1000, imported: false, exempt: false)
    expect(p.calculate_item_tax).to eq(100)
  end

  it "calculate_total_tax" do
    p1 = Product.new(name: "Great Gatsby 1", price: 1000, imported: false, exempt: false)
    p2 = Product.new(name: "Great Gatsby 2", price: 1500, imported: false, exempt: false)
    p3 = Product.new(name: "Great Gatsby 3", price: 2000, imported: false, exempt: false)
    expect(Product.calculate_tax([p1, p2, p3])).to eq(450)
  end

  it "calculate_import" do
    p1 = Product.new(name: "Great Gatsby 1", price: 1000, imported: true, exempt: true)
    p2 = Product.new(name: "Great Gatsby 2", price: 1500, imported: false, exempt: false)
    p3 = Product.new(name: "Great Gatsby 3", price: 2000, imported: true, exempt: true)
    expect(Product.calculate_import([p1, p2, p3])).to eq(150)
  end

  it "calculate_total_price" do
    p1 = Product.new(name: "Great Gatsby 1", price: 1000, imported: true, exempt: true)
    p2 = Product.new(name: "Great Gatsby 2", price: 1500, imported: false, exempt: false)
    p3 = Product.new(name: "Great Gatsby 3", price: 2000, imported: true, exempt: true)
    expect(Product.calculate_total_price([p1, p2, p3])).to eq(4800)
  end

end