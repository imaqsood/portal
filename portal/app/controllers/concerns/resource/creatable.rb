module Resource
  module Creatable
    extend ActiveSupport::Concern

    included do
      include Helper::New
      include Helper::Render
    end

    def create
      render_resource new_resource.save
    end
  end
end
