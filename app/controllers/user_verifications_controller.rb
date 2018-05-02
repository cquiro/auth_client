class UserVerificationsController < ApplicationController
  def new
  end

  def create
    response = User.new().verify_user({ email: params[:email],
                                        image: base64_image(params[:image]) }) 

    if response.code == 200
      flash.now[:success] = 'User verified.'
      render :new, status: :ok
    else
      flash.now[:error] = 'Unauthorized user.'
      render :new, status: :unauthorized
    end
  end

  private

  def base64_image(uploaded_image)
    Base64.strict_encode64(File.read(uploaded_image.tempfile))
  end
end
