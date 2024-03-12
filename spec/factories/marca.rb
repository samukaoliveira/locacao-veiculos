FactoryBot.define do
    factory :marca do
        nome { Faker::Vehicle.manufacture }
        sigla { Faker::Vehicle.manufacture }
    end
end