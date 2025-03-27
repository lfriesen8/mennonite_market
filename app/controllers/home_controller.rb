class HomeController < ApplicationController
  def index
    @products = Product.all

    if params[:sale]
      @products = @products.where(sale: true)
    end

    if params[:new]
      @products = @products.where('created_at > ?', 3.days.ago)
    end

    if params[:updated]
      @products = @products.where('updated_at > ?', 3.days.ago)
    end

    # Add pagination
    @products = @products.page(params[:page]).per(10)  # Here, 10 is the number of products per page
  end
end

