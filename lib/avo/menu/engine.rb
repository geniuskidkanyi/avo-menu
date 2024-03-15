module Avo
  module Menu
    class Engine < ::Rails::Engine
      isolate_namespace Avo::Menu

      initializer "avo-menu.init" do
        if defined?(Avo)
          Avo.plugin_manager.register Avo::Menu::Plugin
        end
      end
    end
  end
end
