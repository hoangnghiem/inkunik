class Account::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource

    if verify_recaptcha(:model => resource, :message => t('captcha.invalid'), :private_key => APP_CONFIG["recaptcha"]["private_key"] ) && resource.save
      set_flash_message :notice, :signed_up
      sign_in_and_redirect(resource_name, resource)
    else
      clean_up_passwords(resource)
      render_with_scope :new
    end
  end
end
