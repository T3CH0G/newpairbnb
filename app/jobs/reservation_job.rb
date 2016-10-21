class ReservationJob < ActiveJob::Base
  queue_as :default

  def perform(booking,host)
     ReservationMailer.notification_email(booking,host).deliver_now
  end
end
