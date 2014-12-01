module ApplicationHelper
  def markdown(text)
    @markdown ||= Redcarpet::Markdown.new(renderer, no_intra_emphasis: true, tables: true, autolink: true)

    @markdown.render(text).html_safe
  end

  def renderer
    @renderer ||= Redcarpet::Render::HTML.new(filter_html: true, no_styles: true, safe_links_only: true)
  end
end
