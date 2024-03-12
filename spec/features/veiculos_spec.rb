require 'rails_helper'

RSpec.feature "Veiculos", type: :feature, js: true do
  Capybara.default_max_wait_time = 10

  fixtures :admins

  RSpec.configure do |config|
    config.before(:suite) do
      # Executar o comando para popular o banco de dados de teste
      system('rails db:seed RAILS_ENV=test')
    end
  
    # ... outras configurações ...
  end

  def realizar_busca_veiculos(termo, success)
    success = success
    find('input#busca').click
    sleep(1)
    find('input#busca').send_keys(termo)
    sleep(2)
    find('button', text: 'Pesquisar', wait: 1).click
    sleep(2)
    page.save_screenshot("#{termo}_search.png")
    expect(page).to have_content(/#{Regexp.escape(termo)}/i)
    sleep(2)
    # expect(page).to have_content("No results found")
    # sleep(2)
  end

  context "Buscar" do
    it "Search Marca with success" do

      ActiveRecord::Base.connection.disable_referential_integrity do
        admin = create(:admin)
        marca = create(:marca)
        
        # nomes_especificos = ["Gragoatá", "Praia Vermelha", "Valonguinho", "Reitoria", "Farmácia"]
        # FactoryBot.create_list(:unidade, 5, nomes_especificos: nomes_especificos)

        
        sleep(3)
        visit(marcas_path)
        
        # realizar_busca_unidade('Grag', true)
        # realizar_busca_unidade('centro', true)
        # realizar_busca_unidade('Frias', true)

        expect(page).to have_content("Sigla")
      end
    end

    it "Search Unit without success" do

      ActiveRecord::Base.connection.disable_referential_integrity do
        admin = create(:admin)
        marca = create(:marca)
        10.times do
          veiculo = create(:veiculo)
        end
        cliente = create(:cliente)
        sleep(1)
        visit(root_path)
        sleep(1)
        realizar_busca_veiculos('a', true)
      end
    end
  end



end
