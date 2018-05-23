require "faw_icon/version"

module FawIcon
  def faw_icon(style, name, options = {})
    fa_prefix = 'fa'
    html_props = {}

    html_props[:class] = [fa_style(style), "#{fa_prefix}-#{name}"]
    html_props[:class] << "#{fa_prefix}-#{options[:size]}" if options[:size]
    html_props[:class] << "#{fa_prefix}-fw" if options[:fixed_width]
    html_props[:class] << "#{fa_prefix}-spin" if options[:spin]

    tag = []
    tag << "<i class='#{html_props[:class].join(' ')}'"
    tag << " data-fa-transform='#{options[:transform]}'" if options[:transform]
    tag << " data-fa-mask='#{options[:mask]}'" if options[:mask]
    tag << '></i>'

    tag.join( '').html_safe
  end

  def fa_style(style)
    case style
      when 'solid'
        'fas'
      when 'regular'
        'far'
      when 'light'
        'fal'
      when 'brand'
        'fab'
    end
  end
end
