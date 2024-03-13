module ClientesHelper

    def tipo_form
        if controller.controller_name == "clientes" && controller.action_name == "new"
            return "Novo Cadastro"
        elsif controller.controller_name == "clientes" && controller.action_name == "edit"
            return "Editar Perfil"
        end
    end
end
