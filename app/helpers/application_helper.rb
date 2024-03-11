module ApplicationHelper

    def no_image_check(model, size, iclass = "")
        if model.imagem.attached?
            return image_tag model.imagem.variant(size), class: iclass
        else
            default_size = case size
                            when :cart_avatar then '45x27'
                            when :small_avatar then '100x60'
                            when :small_thumb then '150x90'
                            when :mid1_thumb then '200x120'
                            when :mid2_thumb then '300x180'
                            when :big_thumb then '400x240'
                            else '150x90'
                            end
            return image_tag 'no_image', size: default_size, class: iclass
        end
    end

    def image_purge(model)
        return model.imagem.purge
    end

end
