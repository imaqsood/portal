module Resource
  module Helper
    module Params
      extend ActiveSupport::Concern

      included do
        include Naming
      end

      private

      def resource_params
        params.require(resource_name).permit(*resource_attributes)
      end

      def resource_attributes
        resource_class.columns.map(&:name).map(&:to_sym) - %i[id created_at updated_at]
      end
    end
  end
end
