class HomeController < ApplicationController
  def index
    @categories = Category.all  # Fetch all categories
    @products = Product.all

    # Filter by sale
    @products = @products.where(sale: true) if params[:sale]

    # Filter by new arrivals (created in the last 3 days)
    @products = @products.where('created_at > ?', 3.days.ago) if params[:new]

    # Filter by recently updated (updated in the last 3 days)
    @products = @products.where('updated_at > ?', 3.days.ago) if params[:updated]

    # Filter by category if passed
    if params[:category_id]
      @products = @products.where(category_id: params[:category_id])
    end

    # Pagination
    @products = @products.page(params[:page]).per(10)
  end
end
