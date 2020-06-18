class CustomerSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :links

  type :customer

  def name
    object.name.titleize
  end

  def links
    [
      {
        rel: :self,
        href: v1_customer_url(object)
      }
    ]
  end
end
