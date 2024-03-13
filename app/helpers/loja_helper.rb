module LojaHelper

    def menu_item(texto, path, control_name)

        texto = texto
        path = path
        control_name = control_name

        # return '<td class="bg-transparent text-dark" >
        # <%= link_to "#{texto}", #{path}, class:" custom-a nav-link active d-inline #{ "text-light" unless controller.controller_name == "#{controller}"}" %>
        # </td>'.html_safe
        css_link = 'text-light' unless controller.controller_name == control_name

        return content_tag(:td, (link_to texto, path, class: "custom-a nav-link active d-inline #{ css_link }"), class: "bg-transparent text-dark")

    end
end
