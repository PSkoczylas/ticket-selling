class Api::V1::TicketPurchasesController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  def initialize(mainRepository = TicketRepository)
    @repo = TicketPurchaseRepository
    @serializer = TicketPurchaseSerializer
  end

  # POST /api/v1/events/:event_id/tickets/:ticket_id/ticket_purchase
  def create    
    @ticket = TicketRepository.find(params[:ticket_id])
    @requested_quantity = params[:quantity].to_i || 1
    if @requested_quantity > @ticket.available_quantity
      render json: { message: "Requested quantity is more than available" }, status: :not_acceptable
    else
      @purchase_result = TicketPurchaseService.Payment(@requested_quantity, @ticket)
      @ticket_purchases = @repo.create(@purchase_result, ticket_purchase_params)
      render json: serialize(@ticket_purchases), status: :created
    end
  end

  private

  def ticket_purchase_params
    params.require(:ticket_purchase).permit(:email, :ticket_id, :token)
  end
end