class TicketSerializer
  include FastJsonapi::ObjectSerializer
  set_type :ticket
  attributes :info, :price, :currency, :available_quantity
  belongs_to :event
end
