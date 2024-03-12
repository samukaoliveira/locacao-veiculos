class Marca < ApplicationRecord

    has_many :veiculos

    validates :nome, :sigla, presence: true
end
