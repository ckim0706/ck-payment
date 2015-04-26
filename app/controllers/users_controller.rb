class UsersController < ApplicationController
  def create
    @user = User.new(params[:user])

    if @user.save
      UserMailer.send_signup_email(@user).deliver
      redirect_to(@user, :notice => 'User created')
    else
      render :action => 'new'
    end
  end
end