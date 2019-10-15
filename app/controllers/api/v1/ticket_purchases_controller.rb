class Api::V1::TicketPurchasesController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  def initialize(mainRepository = TicketRepository)
    @repo = TicketPurchaseRepository
    @serializer = TicketPurchaseSerializer
  end

  # POST /api/v1/events/:event_id/tickets/:ticket_id/ticket_purchase
  def create    
    @ticket = TicketRepository.find(params[:ticket_id])
    @purchase_result = TicketPurchaseService.payment(@ticket, ticket_purchase_params)
    @ticket_purchase = @repo.create(@purchase_result, ticket_purchase_params)
    render json: serialize(@ticket_purchase), status: :created
  end

  private

  def ticket_purchase_params
    params.require(:ticket_purchase).permit(:email, :ticket_id, :token, :amount)
  end
end