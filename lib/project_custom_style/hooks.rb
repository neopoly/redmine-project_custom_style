module ProjectCustomStyle
  class Hooks < Redmine::Hook::ViewListener
    STYLE_WRAPPER = %(<style type="text/css">%s</style>)

    def view_layouts_base_html_head(context)
      page = find_wiki_page(context)
      wrap_style_content(page.content.text) if page
    end

    def view_projects_contextual(context)
      link_to(
        l("project_custom_style_label"),
        edit_path(context),
        class: "icon icon-copy"
      )
    end

    private

    def edit_path(context)
      edit_project_wiki_page_path(
        project_id: context[:project].id,
        id: custom_style_wiki_page
      )
    end

    def custom_style_wiki_page
      settings["page"]
    end

    def settings
      Setting.plugin_project_custom_style
    end

    def find_wiki_page(context)
      (project = context[:project]) &&
        project.wiki &&
        project.wiki.find_page(custom_style_wiki_page)
    end

    def wrap_style_content(text)
      if starts_with_style_or_script_tag?(text)
        text
      else
        STYLE_WRAPPER % text
      end
    end

    def starts_with_style_or_script_tag?(text)
      text =~ /\A\s*<(style|script)/
    end
  end
end
