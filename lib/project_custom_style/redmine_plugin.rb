module ProjectCustomStyle
  # Registers this gems a Redmine plugin and applies the needed patches
  class RedminePlugin
    include ProjectCustomStyle::Infos

    DEFAULT_SETTINGS = {
      "page"  => "CustomStyle"
    }.freeze

    SETTING_PARTIAL = "settings/project_custom_style_settings"

    def initialize
      register!
      boot!
    end

    private

    def register!
      Redmine::Plugin.register :project_custom_style do
        name NAME
        author AUTHORS.keys.join(", ")
        description DESCRIPTION
        version VERSION
        url URL
        author_url URL
        directory Engine.root

        settings default: DEFAULT_SETTINGS, partial:  SETTING_PARTIAL
      end
    end

    def boot!
      require "project_custom_style/hooks"
    end
  end
end
