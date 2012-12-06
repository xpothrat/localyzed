module Localyzed

  mattr_accessor :user_interface

  def self.configure(config)
    @@user_interface = config[:user_interface] || nil
  end

  def self.user_interface
    @@user_interface.constantize
  end

  def self.localyze_routes(translations_file,options={})
    ActionDispatch::Routing::Translator.translate_from_file(translations_file, options)
  end
end

require "localyzed/controllers/action_controller_extension"