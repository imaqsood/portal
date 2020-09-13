module Resource
  module Crud
    extend ActiveSupport::Concern

    included do
      include Listable
      include Creatable
      include SingularActions
      include BatchActions
    end
  end
end
