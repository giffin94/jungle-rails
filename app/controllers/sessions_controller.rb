class SessionsController < ApplicationController

  def new
  end

  #   Define a new class method authenticate_with_credentials on the User model.
    # It will take as arguments: the email address and password the user typed into the login form,
    # And return: an instance of the user (if successfully authenticated), or nil (otherwise).
 
  def create
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to :root
    else
      redirect_to :new
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

end
