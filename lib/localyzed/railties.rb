class Localyzed::Railtie < Rails::Railtie
  config.localyzed = ActiveSupport::OrderedOptions.new

  initializer "localized.configure" do |app|
    Localized.configure(app.config.localized)
  end
end