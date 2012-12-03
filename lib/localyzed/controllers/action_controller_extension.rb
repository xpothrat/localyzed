class ActionController::Base

  def url_options
    {:locale => I18n.locale.to_s }.merge(super)
  end

  before_filter :set_locale

  # redirects_to localized path if path not loaclized and request not ajax or api
  before_filter :redirect_to_localized_path_if

  # sets the locale by checking user data then request param then session data then retrieving accept language data 
  def set_locale
    if Localyzed.user_interface && Localyzed.user_interface.signed_in? and cl = Localyzed.user_interface.current.language and I18n.available_locales.include?(cl)
      locale = I18n.locale = cl
      session[:locale] = locale
    else
      define_locale
    end
  end

  # if !request.xhr then non ajax request then ensure the path is localized (/^(en|fr)\/.*/)
  def redirect_to_localized_path_if
    @translatable = true # used to display or hide the languages menu
    if ( !request.xhr? && ( !request.path.match(/\/(en|fr)(\/|$)/) || params[:locale] != I18n.locale.to_s) && request.method == 'GET')
      flash.keep
      # rediredct 302 for root / 301 for other pages
      if request.path == '/'
        params.delete(:action) # removes the action param from params so that it doesn't appear anymore in the redirected url ("?action=root")
        redirect_to home_path(params.merge(:locale => I18n.locale.to_s))
      else
        redirect_to(url_for(params.merge(:locale => I18n.locale.to_s, :from_l => (params[:locale] if params[:locale]))), :status => :moved_permanently)
      end
    end
  end

  private

  def define_locale
    requested_locale = params[:locale] || session[:locale] || cookies[:locale] ||  request.env['HTTP_ACCEPT_LANGUAGE'] || I18n.default_locale
    session[:locale] = locale
    I18n.locale = locale
  end
end