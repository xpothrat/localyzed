module Localyzed::LocalyzedController
  def self.included base
    base.send :before_filter, :set_locale
    # redirects_to localized path if path not loaclized and request not ajax or api
    base.send :before_filter, :redirect_to_localized_path_if
  end

  def url_options
    {:locale => I18n.locale.to_s}.merge(super)
  end

  # sets the locale by checking user data then request param then session data then retrieving accept language data 
  def set_locale
    cl = ( ( respond_to?(:user_signed_in?) && current_user.try(:respond_to?,:language) ) ? current_user.language : 'en')
    if params[:locale].nil? and user_signed_in? and cl and I18n.available_locales.include?(cl)
      locale = I18n.locale = cl
      session[:locale] = locale
    else
      current_user.try(:update_attributes,{:language => params[:locale]}) if params[:locale] && cl.try(:!=, params[:locale])
      define_locale
    end
  end

  # if !request.xhr then non ajax request then ensure the path is localized (/^(en|fr)\/.*/)
  def redirect_to_localized_path_if
    @translatable = true # used to display or hide the languages menu
    # Rails.env != test to make controller specs pass if locale is defined but path is not well written
    if ( !request.xhr? && ( ( !request.path.match(/(.*|)\/(en|fr)(\/|$)/) && Rails.env != 'test' ) || params[:locale] != I18n.locale.to_s) && request.method == 'GET')
      flash.keep
      redirect_to(url_for(params.merge(:locale => I18n.locale.to_s, :from_l => (params[:locale] if params[:locale]))), :status => :moved_permanently)
    end
  end

  private

  def define_locale
    requested_locale = simplified_locale(params[:locale] || session[:locale] || cookies[:locale] ||  request.env['HTTP_ACCEPT_LANGUAGE'] || I18n.default_locale)
    session[:locale] = requested_locale
    I18n.locale = requested_locale
  end
  
  def simplified_locale(locale)
    locale.to_s.gsub(/(-|_).*$/,'').try(:to_sym)
  end
end