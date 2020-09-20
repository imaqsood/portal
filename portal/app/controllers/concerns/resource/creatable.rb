module Resource
  module Creatable
    extend ActiveSupport::Concern

    included do
      include Helper::New
      include Helper::Render
    end

    def create
      new_resource.save
      render_resource
    end
  end
end
