class Admins::UsersController < Admins::BaseController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    user = User.find(params[:id])
    user.destroy!
    redirect_to admins_users_path, flash[:notice] = 'ユーザーを削除しました', status: :see_other
  end
end
