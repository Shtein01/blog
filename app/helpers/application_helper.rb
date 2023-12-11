module ApplicationHelper
  def page_title(separator = " – ")
    [content_for(:title), 'Blog'].compact.join(separator)
  end

  def page_heading(title)
    content_for(:title){ title }
    content_tag(:h3, title)
  end
end
