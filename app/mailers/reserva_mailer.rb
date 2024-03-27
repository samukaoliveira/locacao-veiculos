class ReservaMailer < ApplicationMailer

    def reserva_cadastrada(cliente)
        @cliente = cliente
        mail(to: @cliente.email, subject: "SamCar - Sua Reserva foi cadastrada")

    end

    def pagamento_confirmado(cliente)
        @cliente = cliente
        mail(to: @cliente.email, subject: "SamCar - Seu pagamento foi aprovado")

    end
end
