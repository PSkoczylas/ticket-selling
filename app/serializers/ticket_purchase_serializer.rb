class TicketPurchaseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :token
end
