FactoryBot.define do
    factory :veiculo do
        nome { Faker::Vehicle.model }
        cor { Faker::Vehicle.color }
        qnt_passageiros { Faker::Number.number(digits: 1) }
        ano { Faker::Vehicle.year }
        placa { Faker::Vehicle.license_plate }
        valor { Faker::Number.decimal(l_digits: 2) }
        association :marca, factory: :marca
    end
end