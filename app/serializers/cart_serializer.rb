class CartSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :status, :total_amount, :customer_id, :total_amount, :cart_items, :links

  belongs_to :customer do
    link(:related) { v1_customer_url(object.customer_id) }
  end
  has_many :cart_items

  def links
    [
      {
        rel: :self,
        href: v1_customer_cart_url(object.customer_id, object)
      }
    ]
  end
end
