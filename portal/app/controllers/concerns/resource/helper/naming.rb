module Resource
  module Helper
    module Naming
      private

      def resource_class
        @resource_class ||= controller_name.classify.constantize
      end

      def resource_name(type = :singular)
        (@resource_name ||= {})[type] ||= resource_class.model_name.send(:singular).to_sym
      end
    end
  end
end
