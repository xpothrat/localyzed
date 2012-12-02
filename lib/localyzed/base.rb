module Localyzed

  def self.configure(config)
    @@user_interface = config[:user_interface]
  end
end

require "localyzed/controllers/action_controller_extension"