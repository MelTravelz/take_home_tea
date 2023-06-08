class SubscriptionPresenter
  attr_reader :id, :all_sub_info

  def initialize(user)
    @id = nil
    @all_sub_info = get_all_info(user)
  end

  def get_all_info(user)
    user.user_subscriptions.map do |sub|
      { 
        user_subscription_id: sub.id,
        status: sub.status,
        frequency: sub.frequency,
        title: sub.subscription.title,
        price_usd: sub.subscription.price_usd
      }
    end
  end
end