require "project_custom_style/redmine_plugin"

module ProjectCustomStyle
  # Simple engine to support the Redmine plugin
  class Engine < ::Rails::Engine
    config.to_prepare do
      RedminePlugin.new
    end
  end
end
