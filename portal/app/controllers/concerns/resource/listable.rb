module Resource
  module Listable
    extend ActiveSupport::Concern

    included do
      include Helper::Accessor
      before_action :set_resources, only: %i[index]
    end

    def index
      render json: resources
    end
  end
end
