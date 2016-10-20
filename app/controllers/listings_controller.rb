class ListingsController < ApplicationController

   before_action :set_listing, only: [:show, :edit, :update, :destroy]

	def profile
		@my_listings = current_user.listings
	end

  def new
  	@listing = Listing.new
  end

  def create
  		@listing=current_user.listings.new(listing_params)
      @listing.schedule = IceCube::Schedule.new(Date.today, duration: 1.day)
      @listing.schedule.add_recurrence_rule IceCube::Rule.daily
  	 	if @listing.save
    		redirect_to @listing
  		else
    		render :new
  		end
  end

  def edit
  end

  def update
    @listing.update(listing_params)
      if @listing.save
        redirect_to @listing
      else 
        render :edit
      end
  end

  def show
  end

  def book
    @listing = Listing.find(params[:id])
    @user=User.find(@listing.user_id)
    from= Time.strptime(params[:from], "%m/%d/%Y")
    to= Time.strptime(params[:to], "%m/%d/%Y")
    amount=params[:amount].to_i
    @listing.be_booked! @user, time_start: from, time_end: to, amount: amount
        render :book
  end

  def index
    if params[:tag]
      @listings = Listing.tagged_with(params[:tag])
    else
      @listings = Listing.all
    end
  end

  def destroy
    @listing.destroy
    redirect_to listings_path 
  end

  def tag
  end

  def listing_params
    params.require(:listing).permit(:title,:description,:tag_list,:capacity, {avatars:[]})
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

end


#render new will just load the erb straight away, redirect is go to action in controller and then render


