class UsersController < ApplicationController

before_action :set_user, only: [:show]

	def show
	end

	def index
		@user=User.all.paginate(:page => params[:page], :per_page => 5)
	end
	
	private
	def set_user
		@c_user = User.find(params[:id])
	end
end