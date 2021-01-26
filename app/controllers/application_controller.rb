class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale)
    if I18n.available_locales.include?(locale) == true then locale
    else
      I18n.default_locale
    end
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
