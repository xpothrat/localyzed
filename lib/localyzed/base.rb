module Localyzed

  def self.configure(config)
  end

  def self.localyze_routes(translations_file,options={})
    ensure_translations_file_exists(translations_file)
    ActionDispatch::Routing::Translator.translate_from_file(translations_file, options)
  end
  
  def self.ensure_translations_file_exists translations_file
    translate_filepath = Rails.root.join(translations_file)
    unless File.exists?(translate_filepath)
      FileUtils.mkdir_p(File.dirname(translate_filepath))
      File.open(translate_filepath, 'a'){}
    end
    unless d = YAML::load_file(translate_filepath)
      I18n.available_locales.each do |l|
        d ||= {}.merge!({ :"#{l.to_s}" => {:routes => {}} } )
      end
      File.write(translate_filepath, d.to_yaml)
    end
  end
end

require "localyzed/controllers/action_controller_extension"