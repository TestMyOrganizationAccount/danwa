class SessionsController < ApplicationController
  def new
  end

  def create
  @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      login @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_back_or @user
    else
      flash.now[:danger] = 'メールアドレス、またはパスワードが正しくありません'
      render 'new'
    end
  end

  def destroy
    logout if logged_in?
    redirect_to root_url
  end
end
