require 'rails_helper'

RSpec.describe Api::V1::TicketsController, type: :controller do
  describe 'GET #index' do
    let!(:event) { create(:event) }

    let!(:tickets) { create_list(:ticket, 15, event: event) }

    let!(:other_event_tickets) { create_list(:ticket, 10) }

    before do
      repo = TicketRepository
      allow(repo).to receive(:all) { tickets }
      controller.instance_variable_set(:@repo, repo)
      get :index, params: { event_id: event.id }, format: :json
    end

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_successful
      expect(response).to have_http_status(:success)
    end

    it 'loads all of the tickets for given event into @tickets' do
      expect_json_sizes(data: tickets.length)
    end
  end
end