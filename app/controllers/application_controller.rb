class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def after_sign_up_path_for(resource)
    if resource.is_a?(Admin) # .is_a?メソッド：オブジェクトが特定のクラスまたはそのサブクラスのインスタンスかを確認するメソッド
      admins_dashboard_path
    else
      albums_path
    end
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admins_dashboard_path
    else
      albums_path
    end
  end

  # email変更時、認証メールのリンククリック後の遷移先を指定
  def after_confirmation_path_for(resource_name, resource)
    if resource.is_a?(Admin)
      edit_admin_registration_path
    else
      edit_user_registration_path
    end
  end
end
