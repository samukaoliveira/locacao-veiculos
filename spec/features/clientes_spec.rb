require 'rails_helper'

RSpec.feature "Clientes", type: :feature, js: true do
  Capybara.default_max_wait_time = 10

  fixtures :admins

  RSpec.configure do |config|
    config.before(:suite) do
      # Executar o comando para popular o banco de dados de teste
      system('rails db:seed RAILS_ENV=test')
    end
  
    # ... outras configurações ...
  end

  context "CRUD de clientes" do
    it "Cadastro bem-sucedido de clientes" do

      ActiveRecord::Base.connection.disable_referential_integrity do
        
        sleep(1)
        visit(root_path)

        find('a', text: 'Cadastrar', wait: 1).click
        sleep(1)
        find('input#cliente_nome').send_keys("Fulano de Tal")
        sleep(1)
        find('input#cliente_email').send_keys("fulano@gmail.com")
        sleep(1)
        find('input#cliente_cpf').send_keys(12345665422)
        sleep(1)
        find('input#cliente_password').send_keys("456123")
        sleep(1)
        find('input#cliente_password_confirmation').send_keys("456123")
        sleep(1)
        find('input#criar').click
        sleep(2)

        expect(page).to have_content("Cliente was successfully created.")
      end
    end

    it "Cadastro mau-sucedido de clientes" do

      ActiveRecord::Base.connection.disable_referential_integrity do
               
        sleep(1)
        visit(root_path)

        find('a', text: 'Cadastrar', wait: 1).click
        sleep(1)
        find('input#cliente_nome').send_keys("Fulano de Tal")
        sleep(1)
        find('input#cliente_email').send_keys("fulano@gmail.com")
        sleep(1)
        find('input#cliente_cpf').send_keys(12345665422)
        sleep(1)
        find('input#cliente_password').send_keys("456123")
        sleep(1)
        find('input#criar').click
        sleep(2)

        expect(page).to have_content("Password confirmation não pode ficar em branco")
      end
    end

    it "Edição bem-sucedida de clientes" do

      ActiveRecord::Base.connection.disable_referential_integrity do
        admin = create(:admin)
        marca = create(:marca)
        cliente = create(:cliente, marca_id: marca.id)
        
        sleep(1)
        visit(cliente_path(cliente))

        sleep(2)
        find('a', text: 'Edit this cliente', wait: 1).click
        sleep(2)
        20.times do
          find('input#cliente_nome').send_keys(:backspace)
        end
        sleep(1)
        find('input#cliente_nome').send_keys("F-50")
        20.times do
          find('input#cliente_cor').send_keys(:backspace)
        end
        sleep(1)
        find('input#cliente_cor').send_keys("vermelho")
        sleep(1)
        find('.btn').click
        sleep(2)

        expect(page).to have_content("cliente was successfully updated")
      end
    end

    it "Edição mau-sucedida de cliente" do

      ActiveRecord::Base.connection.disable_referential_integrity do
        admin = create(:admin)
        marca = create(:marca)
        cliente = create(:cliente, marca_id: marca.id)
        
        sleep(1)
        visit(cliente_path(cliente))

        sleep(2)
        find('a', text: 'Edit this cliente', wait: 1).click
        sleep(2)
        20.times do
          find('input#cliente_nome').send_keys(:backspace)
        end
        sleep(1)
        find('.btn').click
        sleep(2)

        expect(page).to have_content("Nome não pode ficar em branco")
      end
    end

    it "Exclusão permitida de cliente" do

      ActiveRecord::Base.connection.disable_referential_integrity do
        admin = create(:admin)
        marca = create(:marca)
        cliente = create(:cliente, marca_id: marca.id)
        
        sleep(1)
        visit(cliente_path(cliente))

        sleep(2)
        find('button.btn').click
        sleep(2)

        expect(page).to have_content("cliente was successfully destroyed")
      end
    end
  end

end
