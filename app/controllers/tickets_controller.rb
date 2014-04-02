class TicketsController < ApplicationController

  def create
    event = Event.find_by(:title => params[:title])
    @ticket = Ticket.new
    @ticket.user_id = params[:user_id]
    @ticket.event_id = event.id
    if @ticket.save
      flash[:notice] = "event added"
      redirect_to root_path
    else
      redirect_to("/search/new")
    end
  end

  def index
    @events = current_user.events
    binding.pry
    @ticket = Ticket.find_by(:user_id => current_user, :event_id => params[:id])
  end

  def destroy
    @ticket = Ticket.find_by(:user_id => current_user.id, :event_id => params[:event_id])
    binding.pry
    redirect_to("/")
  end
end
