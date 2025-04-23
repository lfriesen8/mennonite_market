class HomeController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all

    # Filter by sale
    @products = @products.where(sale: true) if params[:sale]

    # Filter by new arrivals (created in the last 3 days)
    if params[:new]
      @products = @products.where('created_at > ?', 3.days.ago)
    end

    # Filter by category
    if params[:category_id].present? && params[:category_id] != "all"
      @products = @products.where(category_id: params[:category_id])
    end

    # Search query logic
    if params[:query].present?
      if params[:category_id].present? && params[:category_id] != "all"
        @products = @products.where(category_id: params[:category_id])
      end

      if params[:category_id].blank? || params[:category_id] == "all"
        @products = @products.where('products.name LIKE ? OR products.description LIKE ?', 
                                    "%#{params[:query]}%", "%#{params[:query]}%")
      end
    end

    # Sorting and pagination
    @products = @products.order(created_at: :desc) if params[:new]
    @products = @products.page(params[:page]).per(10)
  end

  def view_cart
    session[:cart] ||= {}   # Initialize cart if empty
    @cart_products = []

    # Build cart items from session
    session[:cart].each do |product_id, quantity|
      begin
        product = Product.find(product_id)
        @cart_products << { product: product, quantity: quantity.to_i }
      rescue ActiveRecord::RecordNotFound
        Rails.logger.warn "Product with ID #{product_id} not found in DB"
      end
    end

    @total_price = calculate_total_price(@cart_products)
  end

  # Helper method to total up prices
  def calculate_total_price(cart_items)
    cart_items.sum do |item|
      product = item[:product]
      quantity = item[:quantity].to_i

      if product.present? && product.price.present?
        product.price * quantity
      else
        Rails.logger.warn "Skipping item due to missing product or price."
        0
      end
    end
  end

  def add_to_cart
    product_id = params[:product_id].to_s
    quantity = params[:quantity].to_i
    product = Product.find(product_id)

    session[:cart] ||= {}

    # If already in cart, increase quantity; else, set it
    if session[:cart][product_id]
      session[:cart][product_id] += quantity
    else
      session[:cart][product_id] = quantity
    end

    def update_cart
      product_id = params[:product_id].to_s
      new_quantity = params[:quantity].to_i
    
      if session[:cart]&.key?(product_id)
        session[:cart][product_id] = new_quantity
        flash[:notice] = "Quantity updated."
      else
        flash[:alert] = "Product not found in cart."
      end
    
      redirect_to view_cart_path
    end
    
    # Reduce stock in the database
    product.update(stock_quantity: product.stock_quantity - quantity)

    flash[:notice] = "#{product.name} has been added to your cart."
    redirect_to root_path
  end

  def remove_from_cart
    product_id = params[:product_id].to_s

    # Reduce quantity or remove completely
    if session[:cart]&.key?(product_id)
      session[:cart].delete(product_id)
      flash[:notice] = "Item removed from cart."
    else
      flash[:alert] = "Item not found in cart."
    end
    

    redirect_to view_cart_path
  end
end


