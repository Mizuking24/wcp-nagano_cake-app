# frozen_string_literal: true

class Customers::SessionsController < Devise::SessionsController
  before_action :reject_inactive_user, only: [:create]

  protected

  def reject_inactive_user
    @customer = Customer.find_by(email: params[:customer][:email])
    if @customer
      if !@customer.is_active
        redirect_to new_customer_session_path
      end
    end
  end
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
