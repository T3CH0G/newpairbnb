class ReservationMailer < ApplicationMailer

	 default from: 'pairbnbben@gmail.com'

  def notification_email(booking,host)
    @host = host
    @customer = booking.booker
    @listing = booking.bookable
    #once customer reserved a listing, it will send email to the listing host.
    mail(to: @host, subject: "You have received a booking from #{@customer.name}")

  end
end
