class UsersController < ApplicationController
  def index
    @users=User.order(id: :desc).page(params[:page]).per(20)
  end

  def show
    @user=User.find(params[:id])
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
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :prefecture, :year, :introduce, :picture)
    end
end
