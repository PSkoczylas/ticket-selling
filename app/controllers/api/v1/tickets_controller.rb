class Api::V1::TicketsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  def initialize(mainRepository = TicketRepository)
    @repo = TicketRepository
    @serializer = TicketSerializer
  end

  # GET /api/v1/events/:event_id/tickets
  def index
    @tickets = @repo.all(params[:event_id])
    render json: serialize(@tickets)
  end

  # POST /api/v1/events/:event_id/tickets
  def create
    @ticket = @repo.create(ticket_params)
    render json: serialize(@ticket), status: :created
  end

  # DELETE /api/v1/events/:event_id/tickets/:id
  def destroy
    @repo.destroy(@ticket)
    head :no_content
  end

  private

  def ticket_params
    params.require(:ticket).permit(:info, :price, :currency,
                                   :available_quantity, :event_id)
  end
end
