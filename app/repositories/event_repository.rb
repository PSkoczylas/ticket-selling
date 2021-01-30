class EventRepository 
  class << self
    def all
      Event.all
    end

    def find(id)
      Event.find(id)
    end

    def destroy(event)
      event.destroy
    end

    def update(event, params)
      event.update(params)
    end

    def create(params)
      Event.create(params)
    end
  end
end
