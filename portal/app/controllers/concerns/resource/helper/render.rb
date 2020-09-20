module Resource
  module Helper
    module Render
      extend ActiveSupport::Concern

      included do
        include Accessor
        class_attribute :formats, instance_writer: false, default: [:json]
      end

      private

      def responder(object)
        respond_to do |format|
          Array(formats).each do |type|
            format.send(type) { send(:"render_#{type}_#{object}") }
          end
        end
      end

      def render_resource
        responder(:resource)
      end

      def render_resources
        responder(:resources)
      end

      def render_json_resource
        if resource.errors.empty?
          render json: resource, status: :created, location: { action: :show, id: resource.id }
        else
          render json: { errors: resource.errors }, status: :unprocessable_entity
        end
      end

      def render_html_resource
      end

      def render_csv_resource
      end

      def render_xls_resource
      end

      def render_pdf_resource
      end
    end
  end
end
