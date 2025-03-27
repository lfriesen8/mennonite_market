class HomeController < ApplicationController
  def index
    # Get all products
    @products = Product.all

    # Filter by sale
    if params[:sale]
      @products = @products.where(sale: true)
    end

    # Filter by new products (created within the last 3 days)
    if params[:new]
      @products = @products.where('created_at > ?', 3.days.ago)
    end

    # Filter by recently updated products (updated within the last 3 days)
    if params[:updated]
      @products = @products.where('updated_at > ?', 3.days.ago)
    end

    # Add pagination (per 10 products per page for example)
    @products = @products.page(params[:page]).per(10)
  end
end
