json.extract! veiculo, :id, :marca, :cor, :qnt_passageiros, :placa, :created_at, :updated_at
json.url veiculo_url(veiculo, format: :json)
