module Resource
  module SingularActions
    extend ActiveSupport::Concern

    included do
      include Helper::Accessor
      include Helper::Params
      include Helper::Render

      before_action :set_resource, only: %i[show update destroy]
    end

    def show
      render json: resource
    end

    def update
      render_resource resource.update(resource_params)
    end

    def destroy
      resource.destroy
      head :no_content
    end
  end
end
