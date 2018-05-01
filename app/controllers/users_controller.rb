class UsersController < ApplicationController
  def index
    @users = User.new.list_users
  end

  def new
    @user = User.new()
  end

  def create
    response = User.new().create_user({ email: create_params[:email],
                                        image: base64_image(create_params[:image]) }) 

    if response.code == 201
      redirect_to root_path, { notice: "The user has been created." }
    else
      redirect_to new_user_path, { alert: "Could not create the user." } 
    end
  end

  def edit
    @user = User.new(params[:id])
  end

  def update
    response = User.new(params[:id]).update_user({ image: base64_image(update_params[:image]) }) 

    if response.code == 200
      redirect_to root_path, { notice: "The image has been updated." }
    else
      redirect_to edit_user_path(params[:id]), { alert: "Could not update the image." } 
    end
  end

  def destroy
    response = User.new(params[:id]).destroy_user
    if response.code == 204
      redirect_to root_path, { notice: "The user has been deleted." }
    else
      redirect_to edit_user_path(params[:id]), { alert: "Could not delete the user." } 
    end
  end

  private

  def user_api
    @user_api ||= User.new
  end

  def update_params
    params.require(:user).permit(:image)
  end

  def create_params
    params.require(:user).permit(:email, :image)
  end

  def base64_image(uploaded_image)
    Base64.strict_encode64(File.read(uploaded_image.tempfile))
  end
end
