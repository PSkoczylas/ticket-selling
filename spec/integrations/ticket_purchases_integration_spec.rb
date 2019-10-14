require 'rails_helper'

RSpec.describe 'request ticket purchases actions', type: :request do
  it 'creates given ticket' do
    event = create(:event)
    ticket = create(:ticket, event: event)
    post "/api/v1/events/#{event.id}/tickets/#{ticket.id}/ticket_purchases", 
    params: { ticket_purchase: { email: Faker::Internet.email, ticket_id: ticket.id },
              quantity: Faker::Number.between(from: 1, to: ticket.available_quantity).to_i }

    expect(response).to have_http_status(:created)
  end
end