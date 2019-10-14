require 'rails_helper'

RSpec.describe TicketRepository do
  let!(:event) { create(:event) }

  let!(:tickets) { create_list(:ticket, 10, event: event) }

  it 'finds all tickets for given event' do
    result = TicketRepository.all(event.id)
    expect(result.size).to eq(tickets.size)
  end
end