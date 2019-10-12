class Event < ApplicationRecord
  validates :name, presence: true,
                   length: { maximum: 50 }
  validates :start_date, presence: true
  validates :start_time, presence: true
end