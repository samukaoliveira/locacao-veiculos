FactoryBot.define do
    factory :veiculo do
        nome { Faker::Vehicle.model }
        ano { Faker::Vehicle.year }
        placa { Faker::Vehicle.license_plate }
        valor { Faker::Number.decimal(l_digits: 2) }
        association :marca, factory: :marca
    end
end