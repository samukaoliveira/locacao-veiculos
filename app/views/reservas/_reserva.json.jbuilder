json.extract! reserva, :id, :veiculo_id, :cliente_id, :tempo_espera, :valor_total, :dt_inicial, :dt_final, :pagamento_na_retirada, :created_at, :updated_at
json.url reserva_url(reserva, format: :json)
