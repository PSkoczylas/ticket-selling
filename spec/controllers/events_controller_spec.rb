require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do
  describe 'GET #index' do
    let!(:events) { create_list(:event, 20) }

    before do
      repo = EventRepository
      allow(repo).to receive(:all) { events }
      controller.instance_variable_set(:@repo, repo)
      get :index, format: :json
    end

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_successful
      expect(response).to have_http_status(:success)
    end

    it 'loads all of the events into @events' do
      expect_json_sizes(data: events.length)
    end
  end

  describe 'GET #show' do
    context 'when event exists' do
      let!(:event) { create(:event) }
      
      before do
        repo = EventRepository
        allow(repo).to receive(:find) { event }
        controller.instance_variable_set(:@repo, repo)
        get :show, params: { id: event.id }, format: :json
      end

      it 'responds successfully with an HTTP 200 status code' do
        expect(response).to be_successful
        expect(response).to have_http_status(:success)
      end

      it 'loads event into @event' do
        expect_json('data.attributes', name: event.name)
      end
    end

    context 'when event does not exist' do
      before do        
        repo = EventRepository
        allow(repo).to receive(:find)
          .and_raise(ActiveRecord::RecordNotFound.new, "Couldn't find Event")
        controller.instance_variable_set(:@repo, repo)
        get :show, params: { id: 0 }, format: :json
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Event/)
      end
    end
  end

  describe 'POST #create' do
    context 'when request attributes are valid' do
      let(:params) { attributes_for(:event) }

      before do
        event = Event.create(params)
        repo = EventRepository
        allow(repo).to receive(:create) { event }
        controller.instance_variable_set(:@repo, repo)
        request.accept = 'application/json'
        post :create, params: { event: params }
      end

      it 'responds successfully with an HTTP 200 status code' do
        expect(response).to be_successful
        expect(response).to have_http_status(:created)
      end

      it 'responds with created event' do
        expect_json('data.attributes', name: params[:name])
      end
    end

    context 'when request attributes are invalid' do
      let(:error_params) { { description: 'Description without name',
                             start_time: Time.now,
                             date_time: Date.current } }

      before do
        repo = EventRepository
        allow(repo).to receive(:create)
          .and_raise(ActiveRecord::RecordInvalid.new, "Validation failed: Name can't be blank")
        controller.instance_variable_set(:@repo, repo)
        request.accept = 'application/json'
        post :create, params: { event: error_params }
      end

      it 'responds with error for empty name' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end
  
  describe 'PUT #update' do
    let(:params) { attributes_for(:event) }

    context 'when categories exists' do
      let!(:event) { create(:event) }

      before do
        repo = EventRepository
        allow(repo).to receive(:find) { event }
        allow(repo).to receive(:update) { event.update(params) }
        put :update, params: { id: event.id, event: params }
      end

      it 'responds successfully with an HTTP 204 status code' do
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end

      it 'respond with updated event' do
        expect(response.body).to include(params[:name])
      end
    end

    context 'when event does not exist' do
      before do
        repo = EventRepository
        allow(repo).to receive(:find)
          .and_raise(ActiveRecord::RecordNotFound.new, "Couldn't find Event")
        controller.instance_variable_set(:@repo, repo)
        put :update, params: { id: 0, event: params }
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Event/)
      end
    end
  end

  describe 'DELETE /events/:id' do
    let!(:event) { create(:event) }

    before do
      repo = EventRepository
      allow(repo).to receive(:find) { event }
      allow(repo).to receive(:destroy) { event.destroy }
      controller.instance_variable_set(:@repo, repo)
      delete :destroy, params: { id: event.id }
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end