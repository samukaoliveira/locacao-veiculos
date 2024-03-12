class Veiculo < ApplicationRecord

  validates :nome, :cor, :qnt_passageiros, :placa, :ano, :marca_id, presence: true

  belongs_to :marca
  has_one_attached :imagem do |attachable|
    attachable.variant :cart_avatar, resize_to_limit: [45, 27]
    attachable.variant :small_avatar, resize_to_limit: [100, 60]
    attachable.variant :small_thumb, resize_to_limit: [150, 90]
    attachable.variant :mid1_thumb, resize_to_limit: [200, 120]
    attachable.variant :mid2_thumb, resize_to_limit: [300, 180]
    attachable.variant :big_thumb, resize_to_limit: [400, 240]
  end
end
