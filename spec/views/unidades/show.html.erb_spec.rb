require 'rails_helper'

RSpec.describe "unidades/show", type: :view do
  before(:each) do
    assign(:unidade, Unidade.create!(
      nome: "Nome",
      rua: "Rua",
      bairro: "Bairro",
      cidade: "Cidade",
      uf: "Uf",
      numero: 2,
      cep: 3,
      complemento: "Complemento",
      status: false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nome/)
    expect(rendered).to match(/Rua/)
    expect(rendered).to match(/Bairro/)
    expect(rendered).to match(/Cidade/)
    expect(rendered).to match(/Uf/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Complemento/)
    expect(rendered).to match(/false/)
  end
end
