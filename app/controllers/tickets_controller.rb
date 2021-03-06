class TicketsController < ApplicationController

  def create
    event = Event.find_by(:title => params[:title])
    @ticket = Ticket.new
    @ticket.user_id = params[:user_id]
    @ticket.event_id = event.id
    if @ticket.save
      redirect_to root_path
    else
      redirect_to("/search/new")
    end
  end

  def index
    @events = current_user.events
  end

  def destroy
    @ticket = Ticket.where(:id => params["id"]).first
    @ticket.destroy
    redirect_to root_path
  end

end
