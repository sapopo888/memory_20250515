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
    redirect_to admins_users_path, flash[:notice] = t('defaults.flash_message.deleted', item: User.model_name.human), status: :see_other
  end
end
