require 'rails_helper'

RSpec.describe 'request ticket purchases actions', type: :request do
  it 'creates given ticket' do
    event = create(:event)
    ticket = create(:ticket, event: event)
    length = Faker::Number.between(from: 1, to: ticket.available_quantity).to_i
    email = Faker::Internet.email
    post "/api/v1/events/#{event.id}/tickets/#{ticket.id}/ticket_purchases", 
    params: { ticket_purchase: { email: email, ticket_id: ticket.id, amount: length }}

    expect(response).to have_http_status(:created)
    expect_json('data.attributes', email: email, ticket_id: ticket.id, amount: length)
  end
end