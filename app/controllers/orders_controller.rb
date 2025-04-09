class OrdersController < ApplicationController
    def new
        @order = Order.new
      end
      def create
        # Get cart items
        cart = session[:cart] || {}
      
        # Create or find the customer
        customer = Customer.find_or_initialize_by(email: params[:email])
        customer.assign_attributes(
          address: params[:address],
          province: params[:province]
        )
      
        if customer.save
          # Create the order
          order = Order.new(
            customer_id: customer.id,
            total_price: 0 # Will calculate below
          )
      
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
      
            # Apply taxes
            taxes = calculate_taxes(total_price, customer.province)
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
      private

def calculate_taxes(subtotal, province)
  case province.downcase
  when "manitoba"
    pst = subtotal * 0.07
    gst = subtotal * 0.05
    { pst: pst, gst: gst }
  when "ontario"
    hst = subtotal * 0.13
    { hst: hst }
  else
    gst = subtotal * 0.05
    { gst: gst }
  end
end
end