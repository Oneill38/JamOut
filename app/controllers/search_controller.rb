class SearchController < ApplicationController

  def new

  end

  def show
    @results = Event.search(params)

  end

end

