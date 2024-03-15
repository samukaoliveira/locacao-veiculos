FactoryBot.define do
  factory :unidade do
    nome { "MyString" }
    rua { "MyString" }
    bairro { "MyString" }
    cidade { "MyString" }
    uf { "MyString" }
    numero { 1 }
    cep { 1 }
    complemento { "MyString" }
    status { false }
  end
end
