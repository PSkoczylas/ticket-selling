class TicketPurchaseRepository 
  class << self
    def create(purchase_result, params)
      result = []
      
      ActiveRecord::Base.transaction do
        purchase_result.amount.times do
          result << TicketPurchase.create(
            email: params[:email],
            token: purchase_result.token,
            ticket_id: params[:ticket_id]
          )
        end
      end
      result
    end
  end
end
