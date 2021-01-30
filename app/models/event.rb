class Event < ApplicationRecord
  has_many :tickets, dependent: :destroy

  validates :name, presence: true,
                   length: { maximum: 50 }
  validates :start_date, presence: true
  validates :start_time, presence: true
end
