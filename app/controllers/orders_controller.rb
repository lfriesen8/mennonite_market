class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:history]

  def new
    @order = Order.new
  end

  def create
    cart = session[:cart] || {}

    customer, province = if user_signed_in?
      user = current_user
      [build_customer_from_user(user), user.province]
    else
      province = Province.find_by(id: params[:province_id]) || Province.find_by(name: params[:province])
      [build_customer_from_params(province), province]
    end

    if customer&.save
      order = Order.new(customer_id: customer.id, total_price: 0)

      if order.save
        total_price = 0

        cart.each do |product_id, quantity|
          product = Product.find_by(id: product_id)
          next unless product

          subtotal = product.price * quantity.to_i
          total_price += subtotal

          order.order_items.create(
            product_id: product.id,
            quantity: quantity,
            price: product.price
          )
        end

        taxes = calculate_taxes(total_price, province)

        order.update(
          total_price: total_price + taxes.values.sum,
          gst: taxes[:gst],
          pst: taxes[:pst],
          hst: taxes[:hst]
        )

        session[:cart] = {}
        flash[:notice] = "Order placed successfully!"
        redirect_to order_path(order)
      else
        flash[:alert] = "Could not create order."
        redirect_to new_order_path
      end
    else
      flash[:alert] = "Invalid customer details."
      redirect_to new_order_path
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def history
    @customer = Customer.find_by(email: current_user.email)
    @orders = @customer ? @customer.orders.includes(order_items: :product) : []
  end

  private

  def build_customer_from_user(user)
    Customer.find_or_initialize_by(email: user.email).tap do |c|
      c.address = user.address
      c.province_id = user.province_id
    end
  end

  def build_customer_from_params(province)
    return nil unless province

    Customer.find_or_initialize_by(email: params[:email]).tap do |c|
      c.address = params[:address]
      c.province_id = province.id
    end
  end

  def calculate_taxes(subtotal, province)
    return { gst: 0, pst: 0, hst: 0 } unless province.is_a?(Province)

    {
      gst: subtotal * (province.gst || 0),
      pst: subtotal * (province.pst || 0),
      hst: subtotal * (province.hst || 0)
    }
  end
end

