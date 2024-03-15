require 'rails_helper'

RSpec.feature "Marcas", type: :feature, js: true do
  Capybara.default_max_wait_time = 10

  fixtures :admins

  RSpec.configure do |config|
    config.before(:suite) do
      # Executar o comando para popular o banco de dados de teste
      system('rails db:seed RAILS_ENV=test')
    end
  
    # ... outras configurações ...
  end

  def realizar_busca_marcas(termo, success)
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
    it "Visualizando a index de marcas" do

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
    

    it "Buscando Marcas pelo nome" do

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
        realizar_busca_marcas('a', true)
      end
    end
  end

  context "CRUD de marcas" do
    it "Cadastro bem-sucedido de marca" do

      ActiveRecord::Base.connection.disable_referential_integrity do
        admin = create(:admin)
        
        sleep(1)
        visit(marcas_path)

        find('a', text: 'Cadastrar Marca', wait: 1).click
        sleep(1)
        find('input#marca_nome').send_keys("Ferrari")
        sleep(1)
        find('input#marca_sigla').send_keys("F")
        sleep(1)
        find('.btn').click
        sleep(2)

        expect(page).to have_content("Marca was successfully created.")
      end
    end

    it "Cadastro mau-sucedido de marca" do

      ActiveRecord::Base.connection.disable_referential_integrity do
        admin = create(:admin)
        
        sleep(1)
        visit(marcas_path)

        find('a', text: 'Cadastrar Marca', wait: 1).click
        sleep(1)
        find('input#marca_sigla').send_keys("F")
        sleep(1)
        find('.btn').click
        sleep(2)

        expect(page).to have_content("Nome não pode ficar em branco")
      end
    end

    it "Edição bem-sucedida de marca" do

      ActiveRecord::Base.connection.disable_referential_integrity do
        admin = create(:admin)
        marca = create(:marca)
        
        sleep(1)
        visit(marca_path(marca))

        sleep(2)
        find('a', text: 'Edit this marca', wait: 1).click
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

    it "Edição mau-sucedida de marca" do

      ActiveRecord::Base.connection.disable_referential_integrity do
        admin = create(:admin)
        marca = create(:marca)
        
        sleep(1)
        visit(marca_path(marca))

        sleep(2)
        find('a', text: 'Edit this marca', wait: 1).click
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

    it "Exclusão não permitida de marca ja itulizada em cadastro de veículos" do

      ActiveRecord::Base.connection.disable_referential_integrity do
        admin = create(:admin)
        marca = create(:marca)
        veiculo = create(:veiculo, marca_id: marca.id)
        
        sleep(1)
        visit(marca_path(marca))

        sleep(2)
        find('button.btn').click
        sleep(2)

        expect(page).to have_content("Não é possivel excluir")
      end
    end

    it "Exclusão permitida de marca" do

      ActiveRecord::Base.connection.disable_referential_integrity do
        admin = create(:admin)
        marca = create(:marca)
        
        sleep(1)
        visit(marca_path(marca))

        sleep(2)
        find('button.btn').click
        sleep(2)

        expect(page).to have_content("Marca was successfully destroyed")
      end
    end
  end



end
