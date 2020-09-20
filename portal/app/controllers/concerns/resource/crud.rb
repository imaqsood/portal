module Resource
  module Crud
    extend ActiveSupport::Concern

    class_methods do
      def resouce_config(*arg, **options, &block)
        include Listable
        include Creatable
        include SingularActions
        include BatchActions
        self.formats = options.delete(:formats) unless options[:formats].nil?
        yield if block_given?
      end
    end
  end
end
