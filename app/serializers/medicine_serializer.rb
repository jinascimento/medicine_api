class MedicineSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :value, :quantity, :stock, :links

  def links
    [
      {
        rel: :self,
        href: v1_medicine_url(object)
      }
    ]
  end
end
