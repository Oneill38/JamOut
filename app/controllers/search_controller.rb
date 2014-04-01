class SearchController < ApplicationController

  def new

  end

  def show
    @results = Event.search(params)
        binding.pry
  end

end

