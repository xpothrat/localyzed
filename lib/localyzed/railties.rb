class Localyzed::Railtie < Rails::Railtie
  config.localyzed = ActiveSupport::OrderedOptions.new

  initializer "localized.configure" do |app|
    Localyzed.configure(app.config.localyzed)
  end
end