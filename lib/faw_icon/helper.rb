require "faw_icon/version"
require "faw_icon/configuration"
require "rexml/document"

module FawIcon
  def faw_icon(style, name, options = {})
    html_props = {}
    style = 'brands' if style == 'brand'
    fa_prefix = FawIcon.configuration.default_family_prefix

    html_props[:class] = [fa_style(style), "#{fa_prefix}-#{name}"]
    html_props[:class] << FawIcon.configuration.default_replacement_class unless FawIcon.configuration.source_type == 'js'
    html_props[:class] << "#{fa_prefix}-#{options[:size]}" if options[:size]
    html_props[:class] << "#{fa_prefix}-fw" if options[:fixed_width]
    html_props[:class] << "#{fa_prefix}-spin" if options[:spin]
    html_props[:class] << options[:extra_class] if options[:extra_class]
    html_props[:transform] = options[:transform] if options[:transform]
    html_props[:mask] = options[:mask] if options[:mask]
    html_props[:source_type] = FawIcon.configuration.source_type

    case FawIcon.configuration.source_type
      when 'json'
        by_json(style, name, html_props)
      when 'raw'
        by_raw(style, name, html_props)
      when 'sprite'
        by_sprite(style, name, html_props)
      when 'js'
        by_js(html_props)
    end
  end

  def by_json(style, name, html_props)
    icons = JSON.parse(File.read(FawIcon.configuration.icons_path))

    if icons[name].present? && icons[name]['svg'][style].present?
      doc = REXML::Document.new(icons[name]['svg'][style]['raw'])
      svg = doc.root
    end

    fa_tag(svg, html_props)
  end

  def by_raw(style, name, html_props)
    if File.exist? Rails.root.join(FawIcon.configuration.raw_svg_path, style, "#{name}.svg")
      doc = File.open(Rails.root.join(FawIcon.configuration.raw_svg_path, style, "#{name}.svg")) { |f| REXML::Document.new(f) }
      svg = doc.root
    end

    fa_tag(svg, html_props)
  end

  def by_sprite(style, name, html_props)
    if File.exist? Rails.root.join(FawIcon.configuration.svg_sprites_path, "fa-#{style}.svg")
      doc = REXML::Document.new("<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 512 512\"><use href=\"/fa5/svg-sprites/fa-#{style}.svg##{name}\"></use></svg>")
      svg = doc.root
    end

    fa_tag(svg, html_props)
  end

  def by_js(html_props)
    doc = REXML::Document.new('<i>&nbsp;</i>')

    fa_tag(doc.root, html_props)
  end

  def fa_tag(svg = nil, html_props)
    svg = svg_not_found if svg.nil?

    svg.attributes['class'] = html_props[:class].join(' ')
    svg.attributes['data-fa-transform'] = html_props[:transform] if html_props[:transform]
    svg.attributes['data-fa-mask'] = html_props[:mask] if html_props[:mask]
    svg.attributes['data-source-type'] = html_props[:source_type] if html_props[:source_type]

    svg.to_s.html_safe
  end

  def fa_style(style)
    case style
      when 'solid'
        'fas'
      when 'regular'
        'far'
      when 'light'
        'fal'
      when 'brands'
        'fab'
      when 'duotone'
        'fad'
    end
  end

  def svg_not_found
    doc = REXML::Document.new(FawIcon.configuration.icon_not_found)

    doc.root
  end
end
