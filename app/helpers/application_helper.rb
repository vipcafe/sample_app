module ApplicationHelper
  def full_title page_title = ""
    base_title = t("title.msg")
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
