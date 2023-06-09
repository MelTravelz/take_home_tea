class UserSubscriptionSerializer
  include JSONAPI::Serializer
  # when using delegation, only one serializer is needed and all attributes listed here:
  attributes :title, :price_usd, :status, :frequency
end