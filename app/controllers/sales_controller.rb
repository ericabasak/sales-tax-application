class SalesController < ApplicationController

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

    @total_tax = Product.calculate_tax(@cart)
    @total_import = Product.calculate_import(@cart)
    @total_price = Product.calculate_total_price(@cart)
  end

  def clear_session
    session.clear
    # puts '-clearing session-'
    # puts session[:items]
    redirect_to sales_show_url
  end

  # helper method
  def convert_to_dollars(price)
    (price.to_f/100).round(2)
  end

end
