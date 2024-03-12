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

  context "CRUD de veiculos" do
    it "Cadastro bem-sucedido de veiculos" do

      ActiveRecord::Base.connection.disable_referential_integrity do
        admin = create(:admin)
        marca1 = create(:marca)
        marca2 = create(:marca)
        marca3 = create(:marca)
        
        sleep(1)
        visit(veiculos_path)

        find('a', text: 'New veiculo', wait: 1).click
        sleep(1)
        find('input#veiculo_nome').send_keys("F-50")
        sleep(1)
        find('input#veiculo_cor').send_keys("vermelho")
        sleep(1)
        find('input#veiculo_qnt_passageiros').send_keys(3)
        sleep(1)
        find('input#veiculo_placa').send_keys("CDS-2A24")
        sleep(1)
        find('input#veiculo_ano').send_keys("2024-01-24")
        sleep(1)
        find('input#veiculo_valor').send_keys(899.90)
        sleep(1)
        find('.btn').click
        sleep(2)

        expect(page).to have_content("Veiculo was successfully created.")
      end
    end

    it "Cadastro mau-sucedido de veiculos" do

      ActiveRecord::Base.connection.disable_referential_integrity do
        admin = create(:admin)
        marca = create(:marca)
        
        
        sleep(1)
        visit(marcas_path)

        find('a', text: 'New veiculo', wait: 1).click
        sleep(1)
        find('input#marca_sigla').send_keys("F")
        sleep(1)
        find('.btn').click
        sleep(2)

        expect(page).to have_content("Nome não pode ficar em branco")
      end
    end

    it "Edição bem-sucedida de veiculos" do

      ActiveRecord::Base.connection.disable_referential_integrity do
        admin = create(:admin)
        marca = create(:marca)
        veiculo = create(:veiculo, marca_id: marca.id)
        
        sleep(1)
        visit(marca_path(marca))

        sleep(2)
        find('a', text: 'Edit this veiculo', wait: 1).click
        sleep(2)
        20.times do
          find('input#marca_nome').send_keys(:backspace)
        end
        find('input#marca_nome').send_keys("Ferrari")
        sleep(1)
        find('.btn').click
        sleep(2)

        expect(page).to have_content("Ferrari")
      end
    end

    it "Edição mau-sucedida de veiculo" do

      ActiveRecord::Base.connection.disable_referential_integrity do
        admin = create(:admin)
        marca = create(:marca)
        veiculo = create(:veiculo, marca_id: marca.id)
        
        sleep(1)
        visit(marca_path(marca))

        sleep(2)
        find('a', text: 'Edit this veiculo', wait: 1).click
        sleep(2)
        20.times do
          find('input#marca_nome').send_keys(:backspace)
        end
        sleep(1)
        find('.btn').click
        sleep(2)

        expect(page).to have_content("Nome não pode ficar em branco")
      end
    end

    it "Exclusão permitida de veiculo" do

      ActiveRecord::Base.connection.disable_referential_integrity do
        admin = create(:admin)
        marca = create(:marca)
        veiculo = create(:veiculo, marca_id: marca.id)
        
        sleep(1)
        visit(veiculo_path(veiculo))

        sleep(2)
        find('button.btn').click
        sleep(2)

        expect(page).to have_content("Veiculo was successfully destroyed")
      end
    end
  end

end
