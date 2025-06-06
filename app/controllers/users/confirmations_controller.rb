# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  # end

  protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # email変更時、認証メールのリンククリック後の遷移先を指定
  def after_confirmation_path_for(resource_name, resource)
    if user_signed_in?
      edit_user_registration_path
    else
      new_session_path(resource_name)
    end
  end
end
