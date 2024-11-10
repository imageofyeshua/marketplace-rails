class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      start_new_session_for(user)
      redirect_to root_path, notice: "Your account was created successfully"
    else
      render :new
    end
  end

  private

    def user_params
      params.expect(user: [:first_name, :last_name, :email_address, :phone, :zipcode, :password])
    end
end
