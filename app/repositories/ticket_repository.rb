class TicketRepository 
  class << self
    def all(event_id)
      @event = Event.includes(:tickets).find(event_id)
      @event.tickets
    end

    def create(ticket_params)
      Ticket.create(ticket_params)
    end

    def find(id)
      Ticket.find(id)
    end

    def update(event, params)
      Ticket.update(params)
    end
  end
end
