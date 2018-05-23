require 'rails'
require "faw_icon/helper"

module FawIcon
  class Railtie < Rails::Railtie
    initializer "faw_icon.helper" do
      ActionView::Base.send :include, FawIcon
    end
  end
end
