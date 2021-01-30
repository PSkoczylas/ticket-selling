class TicketPurchaseRepository 
  class << self
    def create(purchase_result, params)
      TicketPurchase.create(
        email: params[:email],
        token: purchase_result.token,
        ticket_id: params[:ticket_id],
        amount: purchase_result.amount
      )
    end
  end
end
