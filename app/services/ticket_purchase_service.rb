class TicketPurchaseService
  class << self
    def Payment(requested_quantity, ticket)
      token = SecureRandom.uuid
      result = Adapters::Payment::Gateway.charge(requested_quantity, token, ticket.currency)
      TicketRepository.update(ticket, 
        { available_quantity: ticket.available_quantity - result.amount })
      return result
    end
  end
end
