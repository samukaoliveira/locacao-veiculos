require 'rails_helper'

RSpec.feature "Unidades", type: :feature, js: true do
  Capybara.default_max_wait_time = 10

  fixtures :admins

  RSpec.configure do |config|
    config.before(:suite) do
      # Executar o comando para popular o banco de dados de teste
      system('rails db:seed RAILS_ENV=test')
    end
  
    # ... outras configurações ...
  end

  context "CRUD de Unidades" do
    it "Cadastro bem-sucedido de Unidades" do

      ActiveRecord::Base.connection.disable_referential_integrity do
        admin = create(:admin)
        marca1 = create(:marca)
        marca2 = create(:marca)
        marca3 = create(:marca)
        
        sleep(1)
        visit(veiculos_path)

        find('a', text: 'Cadastrar Unidades', wait: 1).click
        sleep(1)
        find('input#veiculo_nome').send_keys("F-50")
        sleep(1)
        find('input#veiculo_cor').send_keys("vermelho")
        sleep(1)
        find('input#veiculo_qnt_passageiros').send_keys(3)
        sleep(1)
        find('input#veiculo_placa').send_keys("CDS-2A24")
        sleep(1)
        find('input#veiculo_ano').send_keys("2024")
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
        marca1 = create(:marca)
        marca2 = create(:marca)
        marca3 = create(:marca)
        
        sleep(1)
        visit(veiculos_path)

        find('a', text: 'Cadastrar Veiculo', wait: 1).click
        sleep(1)
        find('input#veiculo_cor').send_keys("vermelho")
        sleep(1)
        find('input#veiculo_qnt_passageiros').send_keys(3)
        sleep(1)
        find('input#veiculo_placa').send_keys("CDS-2A24")
        sleep(1)
        find('input#veiculo_ano').send_keys("2024")
        sleep(1)
        find('input#veiculo_valor').send_keys(899.90)
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
        visit(veiculo_path(veiculo))

        sleep(2)
        find('a', text: 'Edit this veiculo', wait: 1).click
        sleep(2)
        20.times do
          find('input#veiculo_nome').send_keys(:backspace)
        end
        sleep(1)
        find('input#veiculo_nome').send_keys("F-50")
        20.times do
          find('input#veiculo_cor').send_keys(:backspace)
        end
        sleep(1)
        find('input#veiculo_cor').send_keys("vermelho")
        sleep(1)
        find('.btn').click
        sleep(2)

        expect(page).to have_content("Veiculo was successfully updated")
      end
    end

    it "Edição mau-sucedida de veiculo" do

      ActiveRecord::Base.connection.disable_referential_integrity do
        admin = create(:admin)
        marca = create(:marca)
        veiculo = create(:veiculo, marca_id: marca.id)
        
        sleep(1)
        visit(veiculo_path(veiculo))

        sleep(2)
        find('a', text: 'Edit this veiculo', wait: 1).click
        sleep(2)
        20.times do
          find('input#veiculo_nome').send_keys(:backspace)
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
