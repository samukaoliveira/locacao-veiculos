json.extract! veiculo, :id, :nome, :cor, :qnt_passageiros, :placa, :marca_id, :created_at, :updated_at
json.url veiculo_url(veiculo, format: :json)
