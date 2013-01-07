module Localyzed

  def self.localyze_routes(translations_file,options={})
    ActionDispatch::Routing::Translator.translate_from_file(translations_file, options)
  end
end

require "localyzed/controllers/action_controller_extension"