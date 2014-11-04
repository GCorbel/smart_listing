class SmartListingPresenter
  delegate :controller_name, :controller_path, to: :controller

  attr_accessor :controller

  def initialize(controller)
    @controller = controller
  end

  def resource_name
    controller_name.to_sym
  end

  def singular_resource_name
    resource_name.to_s.singularize.to_sym
  end

  def view_path
    controller_path
  end

  def view_item_path
    "#{controller_path}/#{singular_resource_name}"
  end

  def view_form_path
    "#{controller_path}/form"
  end

  def resource
    controller.instance_variable_get("@#{singular_resource_name}")
  end
end
