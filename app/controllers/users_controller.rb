class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :verified_user!

  def index
    @search = User.ransack(params[:q])
    @users = @search.result.page(params[:page]).per(20)
  end
end
