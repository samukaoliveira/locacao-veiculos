class Cliente < ApplicationRecord
    has_many :enderecos

    def self.login(email, password)
        Cliente.find_by(email: email, password: password)
    end
end
