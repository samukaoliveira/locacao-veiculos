json.extract! endereco, :id, :logradouro, :complemento, :numero, :cep, :bairro, :cidade, :uf, :cliente_id, :created_at, :updated_at
json.url endereco_url(endereco, format: :json)
