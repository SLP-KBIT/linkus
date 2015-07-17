class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :verified_user!

  def index
  end
end
