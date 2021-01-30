class TicketPurchaseSerializer
  include FastJsonapi::ObjectSerializer
  set_type :ticket_purchase
  attributes :email, :token, :amount, :ticket_id
  belongs_to :ticket
end
