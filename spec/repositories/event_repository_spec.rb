require 'rails_helper'

RSpec.describe EventRepository do
  let(:params) { attributes_for(:event) }

  let!(:event) { create(:event) }

  let!(:events) { create_list(:event, 10) }

  it 'finds all events' do
    expect(EventRepository.all).to eq(Event.all)
  end

  it 'finds given event' do
    expect(EventRepository.find(event.id)).to eq(event)
  end

  it 'destroys given event' do
    event_for_destroy = create(:event)
    size = Event.all.size
    EventRepository.destroy(event)
    expect(size).to eq(Event.all.size + 1)
  end

  it 'updates given event' do
    EventRepository.update(event, params)
    expect(event.name).to eq(params[:name])
  end

  it 'creates event' do
    size = Event.all.size
    EventRepository.create(params)
    expect(Event.last.name).to eq(params[:name])
  end
end
