class Search < ActiveRecord::Base

  def exist?(title, date)
    @event = Event.find_by(title: title, date: date)
  end


  end
