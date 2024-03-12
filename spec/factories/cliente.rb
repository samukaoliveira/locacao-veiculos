FactoryBot.define do
    pass = Faker::Internet.password
    factory :cliente do
        nome { Faker::Name.name }
        email { Faker::Internet.email }
        cpf { Faker::Number.number(digits: 11) }
        password { pass }
        password_confirmation { pass }
    end
end