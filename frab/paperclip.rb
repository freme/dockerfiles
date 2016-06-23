# config/initializers/paperclip.rb
require 'paperclip/media_type_spoof_detector'

Paperclip.options[:command_path] = '/usr/bin'

module Paperclip
  class MediaTypeSpoofDetector
    define_method(:spoofed?) do
      false
    end
  end
end

