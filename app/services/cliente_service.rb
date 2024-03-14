# app/services/cliente_service.rb

class ClienteService
    def self.create_cliente(cliente_params)
      Cliente.create(cliente_params)
    end
  
    def self.update_cliente(cliente_id, cliente_params)
      cliente = Cliente.find(cliente_id)
      cliente.update(cliente_params)
    end
  
    def self.destroy_cliente(cliente_id)
      cliente = Cliente.find(cliente_id)
      cliente.destroy
    end
  end
  