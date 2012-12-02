Rails::Application.configure do
  config.middleware.insert_before(Rack::Lock, Rack::Rewrite) do
    r301 %r{(.*|)\/(en|fr)($|\?[^\\]*)}, '/$1/$2/$3' # redirect '/en' to '/en/'
  end
end