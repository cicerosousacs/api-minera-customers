class SendMailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    # byebug
    SendMail.forgot_password(args.first, args.second, args.third).deliver_now!
  end
end