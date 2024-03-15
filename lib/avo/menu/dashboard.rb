class Avo::Menu::Dashboard < Avo::Menu::BaseItem
  extend Dry::Initializer

  option :name
  option :label, optional: true

  def parsed_dashboard
    dashboard = dashboard_by_id || dashboard_by_name

    raise "Failed to find \"#{name}\" dashboard used in the menu." if dashboard.nil?

    dashboard
  end

  def dashboard_by_name
    Avo::Dashboards.dashboard_manager.get_dashboard_by_name name.to_s
  end

  def dashboard_by_id
    Avo::Dashboards.dashboard_manager.get_dashboard_by_id name.to_s
  end

  def entity_label
    parsed_dashboard.navigation_label
  end
end
