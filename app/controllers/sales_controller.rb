class SalesController < ApplicationController

  def show
    @products = Product.all
  end


  def addItem
    session[:items] = session[:items] || []
    puts '-printing session-'
    puts session[:items]
    @products = Product.all
    session[:items] << @products[0].id
    puts session[:items]
    @items = session[:items]
  
  
    # @selected_products = session[:items]
  
    # @applicable_products = @products.filter()
    # @total_tax = @applicable_products.sum(&:price) * (01)
  
    # @applicable_products_duty = @products.filter()
    # @total_import_duty = @applicable_products_duty.sum(&:price) * (005)
   
    # @total_prices =  @selected_products.sum(&:price) + @total_tax + @total_import_duty
   
    # @total
   
  end
 
  


end
