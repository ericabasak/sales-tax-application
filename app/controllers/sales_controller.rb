class SalesController < ApplicationController

  TAX_RATE = 0.1
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

    @total_price = convert_to_dollars(calculate_total_price(@cart) + calculate_tax(@cart) + @total_import)
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

  def convert_to_dollars(price)
    (price.to_f/100).round(2)
  end

  private

  def api_params
    params.permit(:id)
  end

  def calculate_tax(products)
    taxable_products = products.select {|p| !p.exempt }
    total_price_in_cents = taxable_products.sum(&:price) 
    return total_price_in_cents * TAX_RATE
  end

  def calculate_import(products)
    # taxable_products = products.select {|p| !p.exempt }
    # total_price_in_cents = taxable_products.sum(&:price) 
    # return total_price_in_cents * TAX_RATE
    0
  end

  def calculate_total_price(products)
    products.sum(&:price) 
  end

end
