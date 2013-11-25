require 'rack/rewrite'
class Localyzed::Railtie < Rails::Railtie
  initializer "localized2.configure" do |app|
    app.class.configure do
      config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
        r301 %r{^(\/.*|)\/(en|fr)($|\?[^\\]*)}, '/$1/$2/$3' # redirect '/en' to '/en/'
      end
    end
  end
end
