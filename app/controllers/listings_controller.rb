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

  def index
  	@listings=Listing.all
  end

  def destroy
    @listing.destroy
    redirect_to listings_path 
  end

  private

  def listing_params #whitelist
  	params.require(:listing).permit(:title,:description,:tag_list)
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end

end


#render new will just load the erb straight away, redirect is go to action in controller and then render


