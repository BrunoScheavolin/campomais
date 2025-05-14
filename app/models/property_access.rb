class PropertyAccess < ApplicationRecord
  belongs_to :property
  belongs_to :user

  validates :user_id, uniqueness: {scope: :property_id, message: "já está associado a esta propriedade"}
end
