module Resource
  module Helper
    module New
      extend ActiveSupport::Concern

      included do
        include Naming
        include Params
      end

      private

      def new_resource
        self.resource = resource_class.new(resource_params)
      end
    end
  end
end
