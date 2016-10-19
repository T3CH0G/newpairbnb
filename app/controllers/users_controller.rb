class UsersController < ApplicationController

before_action :set_user, only: [:show]

	def show
	end

	def index
	end
	
	private
	def set_user
		@c_user = User.find(params[:id])
	end
end