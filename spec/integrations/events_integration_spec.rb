require 'rails_helper'

RSpec.describe 'request events actions', type: :request do
  it 'returns all events' do
    events = create_list(:event, 10)
    get "/api/v1/events"
    length = Event.all.size
    expect(response).to have_http_status(200)
    expect_json_sizes(data: length)
    expect_json_types(data: :array)
  end

  it 'shows given event' do
    event = create(:event)
    get "/api/v1/events/#{event.id}"
    expected_time_format = event.start_time.strftime "%H:%M"

    expect(response).to have_http_status(200)
    expect_json('data.attributes', name: event.name, description: event.description,
                                   start_date: event.start_date.to_s, start_time: expected_time_format)
  end

  it 'creates given event' do
    params = attributes_for(:event)
    post "/api/v1/events/", params: { event: params }
    expected_time_format = Time.zone.parse(params[:start_time].to_s).strftime "%H:%M"
    
    expect(response).to have_http_status(:created)
    expect_json('data.attributes', name: params[:name], description: params[:description],
      start_date: params[:start_date].to_s, start_time: expected_time_format)
  end

  it 'updates given event' do
    params = attributes_for(:event)
    event = create(:event)
    put "/api/v1/events/#{event.id}", params: { event: params }
    expect(response).to have_http_status(200)
    expected_time_format = Time.zone.parse(params[:start_time].to_s).strftime "%H:%M"

    expect_json('data.attributes', name: params[:name])
    expect_json('data.attributes', name: params[:name], description: params[:description],
      start_date: params[:start_date].to_s, start_time: expected_time_format)
  end

  it 'destroys given event' do
    event_to_destroy = create(:event)
    size = Event.all.size
    delete "/api/v1/events/#{event_to_destroy.id}"
    expect(response).to have_http_status(204)
    expect(size - 1).to eq(Event.all.size)
  end
end