class UsersController < ApplicationController


before_action :set_user, only: [:show,:update]
skip_before_action :verify_authenticity_token

	def show
	end

	def index
		@user=User.all.paginate(:page => params[:page], :per_page => 5)
	end

	def edit
	end

	def update
		@user.update(user_params)
		 if @user.save
		redirect_to @user
	end
	end
	
	private
	def set_user
		@user = User.find(params[:id])
	end

	def user_params
    params.require(:user).permit(:name,:email,{avatars:[]})
  end

end