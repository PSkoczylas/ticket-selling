class Api::V1::EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  def initialize(mainRepository = EventRepository)
    @repo = EventRepository
    @serializer = EventSerializer
  end

  # GET /api/v1/events
  def index
    @events = @repo.all
    render json: serialize(@events)
  end

  # GET /api/v1/events/:id
  def show
    render json: serialize(@event)
  end

  # POST /api/v1/events
  def create
    @event = @repo.create(event_params)
    render json: serialize(@event), status: :created
  end

  # PUT /events/:id
  def update
    @repo.update(@event, event_params)
    render json: serialize(@event)
  end

  # DELETE /events/:id
  def destroy
    @repo.destroy(@event)
    head :no_content
  end

  private

  def event_params
    params.require(:event).permit(:name, :description,
                                   :start_date, :start_time)
  end

  def set_event
    @event = @repo.find(params[:id])
  end
end
