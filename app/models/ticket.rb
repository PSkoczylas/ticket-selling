class Ticket < ApplicationRecord
  belongs_to :event
  has_many :ticket_purchases
end
