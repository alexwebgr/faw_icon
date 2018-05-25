require "faw_icon/version"

module FawIcon
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :icons_path
    attr_accessor :default_family_prefix
    attr_accessor :default_replacement_class

    def initialize
      @icons_path = 'app/assets/javascripts/icons.json'
      @default_family_prefix = 'fa'
      @default_replacement_class = 'svg-inline--fa'
    end
  end
end
