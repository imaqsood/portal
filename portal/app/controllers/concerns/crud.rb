module Crud
  extend ActiveSupport::Concern

  included do
    protect_from_forgery with: :null_session
    before_action :set_resource, only: %i[show update destroy]
    before_action :set_resources, only: %i[index]
  end

  def index
    render json: resources
  end

  def show
    render json: resource
  end

  def create
    self.resource = resource_class.new(resource_params)
    render_resource resource.save
  end

  def update
    render_resource resource.update(resource_params)
  end

  def destroy
    resource.destroy
    head :no_content
  end

  private

  def render_resource(success)
    if success
      render json: resource, status: :created, location: { action: :show, id: resource.id }
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end

  def resource_class
    @resource_class ||= controller_name.classify.constantize
  end

  def resource_name(type = :singular)
    (@resource_name ||= {})[type] ||= resource_class.model_name.send(:singular).to_sym
  end

  def resource=(resource = resource_class.find(params[:id]))
    instance_variable_set :"@#{resource_name}", resource
  end

  alias set_resource resource=

  def resources=(resources = resource_class.all)
    instance_variable_set :"@#{resource_name(:plural)}", resources
  end

  alias set_resources resources=

  def resource
    instance_variable_get :"@#{resource_name}"
  end

  def resources
    instance_variable_get :"@#{resource_name(:plural)}"
  end

  def resource_params
    params.require(resource_name).permit(*resource_attributes)
  end

  def resource_attributes
    resource_class.columns.map(&:name).map(&:to_sym) - %i[id created_at updated_at]
  end
end
