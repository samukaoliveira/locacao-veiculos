require 'rails_helper'

RSpec.describe "unidades/edit", type: :view do
  let(:unidade) {
    Unidade.create!(
      nome: "MyString",
      rua: "MyString",
      bairro: "MyString",
      cidade: "MyString",
      uf: "MyString",
      numero: 1,
      cep: 1,
      complemento: "MyString",
      status: false
    )
  }

  before(:each) do
    assign(:unidade, unidade)
  end

  it "renders the edit unidade form" do
    render

    assert_select "form[action=?][method=?]", unidade_path(unidade), "post" do

      assert_select "input[name=?]", "unidade[nome]"

      assert_select "input[name=?]", "unidade[rua]"

      assert_select "input[name=?]", "unidade[bairro]"

      assert_select "input[name=?]", "unidade[cidade]"

      assert_select "input[name=?]", "unidade[uf]"

      assert_select "input[name=?]", "unidade[numero]"

      assert_select "input[name=?]", "unidade[cep]"

      assert_select "input[name=?]", "unidade[complemento]"

      assert_select "input[name=?]", "unidade[status]"
    end
  end
end
