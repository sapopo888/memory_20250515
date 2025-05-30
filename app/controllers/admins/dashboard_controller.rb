class Admins::DashboardController < ApplicationController
  before_action :authenticate_admin! # ログイン済みの管理者のみ権限を付与

  def index; end
end
