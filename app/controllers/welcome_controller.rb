class WelcomeController < ApplicationController

  def index
    @user = params[:id]
  end

end
