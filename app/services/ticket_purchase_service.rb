class TicketPurchaseService
  class << self
    def payment(ticket, params)
      @requested_quantity = params[:amount].to_i || 1
      raise RequestedAmountError.new if @requested_quantity > ticket.available_quantity
      @result = Adapters::Payment::Gateway.charge(generate_token, @requested_quantity, ticket.currency)
      TicketRepository.update(ticket, 
        { available_quantity: ticket.available_quantity - @result.amount })
      return @result
    end

    private

    def generate_token
      SecureRandom.uuid
    end
  end
end
