class Admin < ApplicationRecord
    def self.login(email, password)
        Admin.find_by(email: email, password: password)
    end
end
