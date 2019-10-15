class TicketPurchase < ApplicationRecord
  belongs_to :ticket

  before_create { self.ticket.available_quantity -= self.amount }
end
