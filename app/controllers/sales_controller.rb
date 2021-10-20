class SalesController < ApplicationController

  SALES_TAX_RATE = 0.1
  IMPORTED_SALES_TAX_RATE = 0.05

  helper_method :convert_to_dollars

  def show
    @products = Product.all
  end


  def addItem
    params.require('products').permit(:id)
    p = Product.find(params[:products][:id])
    if p.nil?
      render status: 404
    end 
    
    session[:items] = session[:items] || []
    session[:items] << p.id
    
    @cart = []
    session[:items].each do |item|
      @cart << Product.find(item)
    end

    @total_tax = convert_to_dollars(calculate_tax(@cart))
    @total_import = convert_to_dollars(calculate_import(@cart))

    @total_price = convert_to_dollars(calculate_total_price(@cart) + calculate_tax(@cart) + calculate_import(@cart))
    # @selected_products = session[:items]
  
    # @applicable_products = @products.filter()
    # @total_tax = @applicable_products.sum(&:price) * (01)
  
    # @applicable_products_duty = @products.filter()
    # @total_import_duty = @applicable_products_duty.sum(&:price) * (005)
   
    # @total_prices =  @selected_products.sum(&:price) + @total_tax + @total_import_duty
   
    # @total
  end

  def clear_session
    session.clear
    puts '-clearing session-'
    puts session[:items]
    redirect_to sales_show_url
  end

  # helper method
  def convert_to_dollars(price)
    (price.to_f/100).round(2)
  end

  private

  def product_params
    params.permit(:id)
  end

  # calculates the sales tax which is 10% on all items EXCEPT books, food, medical
  def calculate_tax(products)
    taxable_products = products.select {|p| !p.exempt }
    total_price_in_cents = taxable_products.sum(&:price).round(0.05)
    return total_price_in_cents * SALES_TAX_RATE
  end

  # calculates the import duty which is 5% that is an additional sales tax on items that are imported
  def calculate_import(products)
    imported_taxable_products = products.select {|p| p.imported }
    total_price_in_cents = imported_taxable_products.sum(&:price) 
    return total_price_in_cents * IMPORTED_SALES_TAX_RATE
  end

  # non-exempt and imported => 10% + 5%
  # ?????

  def calculate_total_price(products)
    products.sum(&:price)
  end

end
