# coding: utf-8
require 'active_support/secure_random'

class PaymentsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  GATEWAY_ACCOUNT_EMAIL = 'ricardo@ofertachique.com.br'

  def checkout
   if request.post?
      order = PagSeguro::Order.new(UUID.new.generate)
      order.add :id => @product.id, :price => @product.final_value, :description => @product.title

      @user.purchases.create(:product => @product, :gateway => 'PagSeguro', :voucher => '', :status => Purchase::PENDING, :transaction_id => order.id, quantity: params[:item_quant_1]) unless @user.nil? or @product.nil?

      @item_id = order.products[0][:id]
      @item_description = order.products[0][:description]
      @item_price = order.products[0][:price]
      @item_quantity = params[:item_quant_1]
      @item_cobranca = params[:email_cobranca]
      @transaction_id = order.id

      redirect_to "http://pagseguro.uol.com.br/security/webpagamentos/webpagto.aspx?encoding=UTF-8&ref_transacao=#{@transaction_id}&tipo=CP&email_cobranca=#{PaymentController::GATEWAY_ACCOUNT_EMAIL}&item_descr_1=#{CGI::escape(@item_description)}&item_valor_1=#{@item_price}&item_quant_1=#{@item_quantity}&moeda=BRL&item_id_1=#{@item_id}"
    end
  end

  def confirm
    if request.post?
      pagseguro_notification do |n|
        # Aqui você deve verificar se o pedido possui os mesmos produtos
        # que você cadastrou. O produto só deve ser liberado caso o status
        # do pedido seja "completed" ou "approved"
        status = case n.status
                 when :completed then Purchase::COMPLETED
                 when :approved then Purchase::APPROVED
                 when :pending then Purchase::PENDING
                 when :verifying then Purchase::VERIFYING
                 when :refunded then Purchase::REFUNDED
                 when :cancelled then Purchase::CANCELLED
                 else Purchase::UNKNOWN
                 end

        purchase = Purchase.find_by_transaction_id n.mapping_for(:order_id)

        logger.info '**** Payment confirmation: Purchase.nil? ' + purchase.nil?.to_s
        logger.info '**** Payment confirmation: Purchase.status: ' + status.to_s
        logger.info '**** Payment confirmation: status == COMPLETED || status == APPROVED: ' + (status == Purchase::COMPLETED || status == Purchase::APPROVED).to_s

        unless purchase.nil?

          if (status == Purchase::COMPLETED || status == Purchase::APPROVED) && !purchase.payment_approved?
            # Notify the user by email
            Emailer.purchase(purchase.user).deliver
          end

          purchase.status = status
          purchase.save
        end
      end

      render :nothing => true
    end
  end

  def self.generate_transaction_id
    ActiveSupport::SecureRandom.hex(16)
  end

end
