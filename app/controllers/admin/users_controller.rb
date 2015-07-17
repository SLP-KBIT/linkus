class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user!
  before_action :load_user, except: [:index, :new, :create]

  def index
    @search = User.search(params[:q])
    @users = @search.result.page(params[:page]).per(20)
  end

  def edit
    render :show_modal_form
  end

  def update
    @user.update_without_current_password(user_params)
    render :reload
  end

  def destroy
    @user.destroy
    render :reload
  end

  def lock
    @user.lock_access!
    render :reload
  end

  def unlock
    @user.unlock_access!
    render :reload
  end

  private

  def user_params
    params.require(:user).permit(
      :birthday, :role, :laboratory, :position, :phone, :address
    )
  end

  def load_user
    return unless params[:id]
    @user = User.find_by(id: params[:id])
  end
end
