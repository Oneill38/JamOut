class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to("/")
    else
      render :new
    end
  end

  def edit
    @user = current_user
    render :edit
  end

  def update
    @user = current_user
    @user.update(user_params)
    if @user.save
      redirect_to("/")
    else
      render :edit
    end

  end

  def show

  end

  private
  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end


end
