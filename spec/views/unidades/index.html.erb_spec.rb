require 'rails_helper'

RSpec.describe "unidades/index", type: :view do
  before(:each) do
    assign(:unidades, [
      Unidade.create!(
        nome: "Nome",
        rua: "Rua",
        bairro: "Bairro",
        cidade: "Cidade",
        uf: "Uf",
        numero: 2,
        cep: 3,
        complemento: "Complemento",
        status: false
      ),
      Unidade.create!(
        nome: "Nome",
        rua: "Rua",
        bairro: "Bairro",
        cidade: "Cidade",
        uf: "Uf",
        numero: 2,
        cep: 3,
        complemento: "Complemento",
        status: false
      )
    ])
  end

  it "renders a list of unidades" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Nome".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Rua".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Bairro".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Cidade".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Uf".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Complemento".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
  end
end
