class Avo::Menu::Builder
  class << self
    def parse_menu(&block)
      Docile.dsl_eval(Avo::Menu::Builder.new, &block).build
    end
  end

  def initialize(name: nil, items: [])
    @menu = Avo::Menu::Menu.new

    @menu.name = name
    @menu.items = items
  end

  # Adds a link
  def link(name, path = nil, **args)
    path ||= args[:path]
    @menu.items << Avo::Menu::Link.new(name: name, path: path, **args)
  end
  alias_method :link_to, :link

  # Validates and adds a resource
  def resource(name, **args)
    name = name.to_s.singularize
    res = Avo.resource_manager.guess_resource(name)

    if res.present?
      @menu.items << Avo::Menu::Resource.new(resource: name, **args)
    end
  end
  alias_method :resources, :resource

  # Adds a dashboard
  def dashboard(dashboard, **args)
    @menu.items << Avo::Menu::Dashboard.new(name: dashboard, **args)
  end

  # Adds a section
  def section(name = nil, **args, &block)
    @menu.items << Avo::Menu::Section.new(name: name, **args, items: self.class.parse_menu(&block).items)
  end

  # Adds a group
  def group(name = nil, **args, &block)
    @menu.items << Avo::Menu::Group.new(name: name, **args, items: self.class.parse_menu(&block).items)
  end

  # Renders a partial or a view component
  def render(renderable, **args)
    @menu.items << Avo::Menu::Renderable.new(renderable: renderable, **args)
  end

  # Add all the resources
  def all_resources(except: [], **args)
    resources = Avo.resource_manager.resources_for_navigation(current_user)

    Array(except).each do |resource_symbol|
      resources.delete_if do |res|
        res.route_key == resource_symbol.to_s
      end
    end

    resources.each do |res|
      resource res.route_key, **args
    end
  end

  # Add all the dashboards
  def all_dashboards(except: [], **args)
    dashboards = Avo::Dashboards.dashboard_manager.dashboards_for_navigation

    Array(except).each do |dashboard_symbol|
      dashboards.delete_if do |dash|
        dash.id == dashboard_symbol.to_s
      end
    end

    dashboards.each do |dash|
      dashboard dash.id, **args
    end
  end

  # Add all the tools
  def all_tools(**args)
    Avo.tool_manager.tool_partials.each do |partial|
      render partial
    end
  end

  # Fetch the menu
  def build
    @menu
  end

  def context
    Avo::Current.context
  end

  def current_user
    Avo::Current.user
  end

  def params
    Avo::Current.params
  end

  def request
    Avo::Current.request
  end

  def view_context
    Avo::Current.view_context
  end

  def app
    Avo
  end

  def root_path(**args)
    app.root_path(**args)
  end

  def main_app
    view_context.main_app
  end

  def avo
    view_context.avo
  end
end
