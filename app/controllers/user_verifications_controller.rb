class UserVerificationsController < ApplicationController
  def new
  end

  def create
    response = User.new.verify({
      email: params[:email], 
      image: ImageService.new(params[:image]).to_base64,
      user_agent: request.user_agent
    }) 

    if response.code == 200
      flash.now[:success] = 'User verified.'
      render :new, status: :ok
    else
      flash.now[:error] = 'Unauthorized user.'
      render :new, status: :unauthorized
    end
  end
end
