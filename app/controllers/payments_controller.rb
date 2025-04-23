class PaymentsController < ApplicationController
    def create_checkout_session
      cart = session[:cart] || {}
      line_items = []
  
      cart.each do |product_id, quantity|
        product = Product.find(product_id)
        line_items << {
          price_data: {
            currency: 'cad',
            unit_amount: (product.price * 100).to_i, # Stripe expects amount in cents
            product_data: {
              name: product.name
            }
          },
          quantity: quantity
        }
      end
  
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: line_items,
        mode: 'payment',
        success_url: checkout_success_url,
        cancel_url: checkout_cancel_url
      )
  
      redirect_to session.url, allow_other_host: true
    end
  
    def success
      # You can mark the order as paid or show an invoice
      flash[:notice] = "Payment successful! Your order has been placed."
      redirect_to root_path
    end
  
    def cancel
      flash[:alert] = "Payment was cancelled."
      redirect_to cart_path
    end
  end
  