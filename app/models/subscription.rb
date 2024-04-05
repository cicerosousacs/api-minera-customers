class Subscription < ApplicationRecord
  belongs_to :type_subscription

  def self.list
    list = []
    subscriptions = all.order('id asc')
    subscriptions.each do |subscription|
      list << {
        id: subscription.id,
        description: subscription.description,
        quantity_users: subscription.quantity_users,
        type_subscription: subscription.type_subscription.description,
        quantity_companies: subscription.quantity_companies,
        price: subscription.price,
      }
    end

    list
  end
end
