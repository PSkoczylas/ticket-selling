class EventSerializer
  include FastJsonapi::ObjectSerializer
  set_type :event
  attributes :name, :description, 
             :start_date, :start_time
  attribute :start_time do |object|
    "#{object.start_time.strftime "%H:%M"}"
  end
end
