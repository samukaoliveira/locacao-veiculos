class Reserva < ApplicationRecord
  belongs_to :veiculo
  belongs_to :cliente

  enum status: { pagamento_pendente: 0, paga: 1, retirada_pendente: 2, retirada: 3, devolucao_pendente: 4, concluida: 5 }
end
