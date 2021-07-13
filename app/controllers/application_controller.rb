class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :reject_inactive_user, only: [:create]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number])
  end

  def reject_inactive_user
    @customer = Customer.find_by(email: params[:customer][:email])
    if @customer
      if !@customer.is_active
        redirect_to new_customer_session_path
      end
    end
  end

end
