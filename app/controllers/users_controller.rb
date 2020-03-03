class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update]
  
  def index
    @users=User.order(id: :desc).paginate(page: params[:page], per_page: 10).where.not(id: current_user.id)
  end

  def show
    set_user
  end

  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    
    if @user.save
      flash[:success]='ユーザー登録完了しました。'
      redirect_to users_path
    else
      flash.now[:danger]='ユーザー登録に失敗しました。'
      render new_user_path
    end
  end
  
  def edit
    set_user
  end
  
  def update
    set_user
    
    if @user.update(user_params)
      flash[:success]='ユーザー情報の編集をしました。'
      redirect_to user_path
    else
      flash.now[:danger]='ユーザー情報の編集に失敗しました。'
      render edit_user_path
    end
  end
  
  def followings
    set_user
    @followings = @user.followings.paginate(page: params[:page], per_page: 10)
  end
  
  def followers
    set_user
    @followers = @user.followers.paginate(page: params[:page], per_page: 10)
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :prefecture, :year, :introduce, :picture)
    end
end
