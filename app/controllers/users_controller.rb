class UsersController < ApplicationController
  
  #show
  def show
    @user = self.current_user || User.find(params[:id])
  end
  # render new.rhtml
  def new
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.save
    if @user.errors.empty?
      self.current_user = @user
      redirect_back_or_default(user_path(@user))
      flash[:notice] = "注册成功!"
    else
      render :action => 'new'
    end
  end

end