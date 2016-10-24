class ListingsController < ApplicationController

   before_action :set_listing, only: [:show, :edit, :update, :destroy]
   skip_before_action :verify_authenticity_token

	def profile
		@my_listings = current_user.listings.paginate(:page => params[:page], :per_page => 5)
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

  def search
    @listings = Listing.search(params[:term], fields: ["title", "location"], mispellings: {below: 5})
        if @listings.blank?
          redirect_to listings_path, flash:{danger: "no successful search result"}
        else
          render :search
        end
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
    @cbookings=@listing.bookings.paginate(:page => params[:page], :per_page => 5)
    @listing = Listing.find(params[:id])
  end

  def book
    @listing = Listing.find(params[:id])
    from= Time.strptime(params[:from], "%m/%d/%Y")
    to= Time.strptime(params[:to], "%m/%d/%Y")
    amount=params[:amount].to_i
    price=params[:price].to_i
    @Acts_as_bookable_booking = @listing.be_booked! current_user, time_start: from, time_end: to, amount: amount, total_sum: price*(to.day-from.day)
    @host = @listing.user.email
    ReservationJob.perform_later(@Acts_as_bookable_booking,@host)
    redirect_to payment_path(@Acts_as_bookable_booking)
  end

  def success
    @Acts_as_bookable_booking = Acts_as_bookable_booking.find(params[:id])
    @listing= Listing.find(@Acts_as_bookable_booking.bookable_id)
  end


  def index
    if params[:tag]
      @listings = Listing.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)
    else
      @listings = Listing.all.paginate(:page => params[:page], :per_page => 5)
    end
  end

  def destroy
    @listing.destroy
    redirect_to listings_path 
  end

  def tag
  end

  def listing_params
    params.require(:listing).permit(:title,:description,:tag_list,:capacity,:location,:price, {avatars:[]})
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

end


#render new will just load the erb straight away, redirect is go to action in controller and then render


