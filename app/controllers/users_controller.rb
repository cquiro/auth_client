class UsersController < ApplicationController
  def index
    @users = user_api.list
  end

  def new
    @user = user_api
  end

  def create
    response = user_api.create({
      email: create_params[:email],
      image: ImageService.new(create_params[:image]).to_base64
    }) 

    if response.code == 201
      redirect_to root_path, { notice: "The user has been created." }
    else
      redirect_to new_user_path, { alert: "Could not create the user." } 
    end
  end

  def edit
    @user = user_api(id: params[:id])
  end

  def update
    response = user_api(id: params[:id]).update({
      image: ImageService.new(update_params[:image]).to_base64
    }) 

    if response.code == 200
      redirect_to root_path, { notice: "The image has been updated." }
    else
      redirect_to edit_user_path(params[:id]), { alert: "Could not update the image." } 
    end
  end

  def destroy
    response = user_api(id: params[:id]).destroy

    if response.code == 204
      redirect_to root_path, { notice: "The user has been deleted." }
    else
      redirect_to edit_user_path(params[:id]), { alert: "Could not delete the user." } 
    end
  end

  private

  def user_api(id: nil)
    User.new(user_id: id)
  end

  def update_params
    params.require(:user).permit(:image)
  end

  def create_params
    params.require(:user).permit(:email, :image)
  end
end
