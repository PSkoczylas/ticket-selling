require 'rails_helper'

RSpec.describe 'request tickets actions', type: :request do
  it 'returns all data of tickets for given event' do
    event = create(:event)
    tickets = create_list(:ticket, 10, event: event)
    create_list(:ticket, 5)
    get "/api/v1/events/#{event.id}/tickets"
    expect(response).to have_http_status(200)
    expect_json_sizes(data: tickets.length)
    expect_json_types(data: :array)
  end

  it 'creates given ticket' do
    event = create(:event)
    params = attributes_for(:ticket, event: nil)
    post "/api/v1/events/#{event.id}/tickets", params: { ticket: params }
    
    expect(response).to have_http_status(:created)

    expect_json('data.attributes', info: params[:info], price: params[:price].to_s, event: params[:event_id],
      currency: params[:currency].to_s, available_quantity: params[:available_quantity])
  end
end