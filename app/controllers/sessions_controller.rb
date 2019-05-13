class SessionsController < ApplicationController
  def show
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    
    if @user
      login(@user)
      redirect_to rapidfire.root_path
    else
      flash.now[:errors] = ['Invalid login credentials']
      render :new
    end
  end

  def destroy
    logout
    redirect_to rapidfire.root_path
  end

  private

  def create_params
    params.require(:user).permit(:email,:password)
  end
end
