class StripeWebhooksController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    def receive
      payload = request.body.read
      sig_header = request.env['HTTP_STRIPE_SIGNATURE']
      secret = Rails.application.credentials.dig(:stripe, :webhook_secret)
  
      begin
        event = Stripe::Webhook.construct_event(payload, sig_header, secret)
      rescue JSON::ParserError => e
        Rails.logger.error("Stripe Webhook JSON error: #{e.message}")
        return head :bad_request
      rescue Stripe::SignatureVerificationError => e
        Rails.logger.error("Stripe Signature error: #{e.message}")
        return head :bad_request
      end
  
      case event['type']
      when 'checkout.session.completed'
        session = event['data']['object']
        order_id = session['metadata']['order_id']
        order = Order.find_by(id: order_id)
  
        if order
          order.update!(status: 'paid')
          Rails.logger.info "✅ Order ##{order.id} marked as PAID from webhook"
        else
          Rails.logger.warn "⚠️ Stripe webhook received but order_id #{order_id} not found"
        end
      else
        Rails.logger.info "Unhandled event type: #{event['type']}"
      end
  
      head :ok
    end
  end
  
