# PAYMENT ADAPTER 
# frozen_string_literal: true 

module Adapters 
  module Payment 
    class Gateway 
      Result = Struct.new(:amount, :currency, :token) 
      
      class << self
        def charge(token, amount = 1, currency = "EUR")
          case token.to_sym 
          when :card_error
            raise CardError.new, "Your card has been declined." 
          when :payment_error
            raise PaymentError.new, "Something went wrong with your transaction."
          else 
            Result.new(amount, currency, token)
          end
        end
      end
    end
  end
end
