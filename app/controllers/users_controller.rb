class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!
  before_action :move_to_root, only: :edit
  rescue_from ActiveRecord::RecordNotFound, with: :user_not_found

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end
  private
  def user_params
    params.require(:user).permit(:image, :username, :profile)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def move_to_root
    if @user.id != current_user.id
      redirect_to root_path
    end
  end

  def user_not_found
    flash[:alert] = "存在しないユーザーです。"
    redirect_to root_path
  end
end
