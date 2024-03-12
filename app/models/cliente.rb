class Cliente < ApplicationRecord
    has_many :enderecos

    validates :nome, presence: true
    validates :email, presence: true
    validates :cpf, presence: true, length: { minimum: 11 }
    validates :password, presence: true, length: { minimum: 6 }
    validates :password_confirmation, presence: true
    validates_confirmation_of :password

    def self.login(email, password)
        Cliente.find_by(email: email, password: password)
    end
end
