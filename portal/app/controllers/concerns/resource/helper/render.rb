module Resource
  module Helper
    module Render
      extend ActiveSupport::Concern

      included do
        include Accessor
      end

      private

      def render_resource(success)
        if success
          render json: resource, status: :created, location: { action: :show, id: resource.id }
        else
          render json: resource.errors, status: :unprocessable_entity
        end
      end
    end
  end
end
