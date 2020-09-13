module Resource
  module Helper
    module Accessor
      extend ActiveSupport::Concern

      included do
        include Naming
      end

      private

      def resource
        instance_variable_get :"@#{resource_name}"
      end

      def resource=(resource = resource_class.find(params[:id]))
        instance_variable_set :"@#{resource_name}", resource
      end

      alias set_resource resource=

      def resources
        instance_variable_get :"@#{resource_name(:plural)}"
      end

      def resources=(resources = resource_class.all)
        instance_variable_set :"@#{resource_name(:plural)}", resources
      end

      alias set_resources resources=
    end
  end
end
