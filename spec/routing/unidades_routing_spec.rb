require "rails_helper"

RSpec.describe UnidadesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/unidades").to route_to("unidades#index")
    end

    it "routes to #new" do
      expect(get: "/unidades/new").to route_to("unidades#new")
    end

    it "routes to #show" do
      expect(get: "/unidades/1").to route_to("unidades#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/unidades/1/edit").to route_to("unidades#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/unidades").to route_to("unidades#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/unidades/1").to route_to("unidades#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/unidades/1").to route_to("unidades#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/unidades/1").to route_to("unidades#destroy", id: "1")
    end
  end
end
