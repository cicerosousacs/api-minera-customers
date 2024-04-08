class SendMailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    case args.last
    when 'new_customer'
      SendMail.new_customer(args.first, args.second).deliver_now!
    when 'new_customer_user'
      SendMail.new_customer_user(args.first, args.second, args.third).deliver_now!
    when 'forgot_password'
      SendMail.forgot_password(args.first, args.second, args.third).deliver_now!
    end
  end
end


# def forgot_password_perform(*args)
#   SendMail.forgot_password(args.first, args.second, args.third).deliver_now!
# end

# def new_customer_perform(*args)
#   SendMail.new_customer(args.first, args.second).deliver_now!
# end

# def new_customer_user_perform(*args)
#   SendMail.new_customer_user(args.first, args.second, args.third).deliver_now!
# end