# FawIcon

### Minimalistic ruby gem that exposes a tag helper for Font Awesome icon sets.

By design it does not bundle any icons making it super fast to download and install 
as well as providing the ability to use new icons as they become available, custom ones or the PRO collection.  

[![Gem Version](https://badge.fury.io/rb/faw_icon.svg)](https://badge.fury.io/rb/faw_icon)     
[![Gitter chat](https://img.shields.io/badge/join_the_chat-gitter-brightgreen.svg)](https://gitter.im/faw_icon/Lobby)     

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'faw_icon'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install faw_icon
    
You will need to download the .zip folder from [Font Awesome](https://fontawesome.com/get-started/svg-with-js)
where you can choose either the free or the PRO collection.

Include in your application.scss the `fontawesome/svg-with-js/css/fa-svg-with-js.css` 
ideally placing in the `app/assets/stylesheets/fa-svg-with-js.css` 

application.scss

    @import "fa-svg-with-js";
    
## Configuration 
The below options are also available for further customization
 
| Property                  | Default                           |
|---------------------------|-----------------------------------|
| icons_path                | app/assets/javascripts/icons.json |
| raw_svg_path              | vendor/fa5/raw-svg                |
| svg_sprites_path          | public/fa5/svg-sprites            |
| source_type               | json (json, raw, sprite, js)      |
| icon_not_found            | `<svg>...</svg>`                  |
| default_family_prefix     | fa                                |
| default_replacement_class | svg-inline--fa                    |

Simply create an initializer under `/config/initializers/faw_icon.rb` and modify as needed !
If you no option is supplied the default will be used
     
```ruby
FawIcon.configure do |config|
  config.icons_path = 'app/assets/javascripts/icons.json'
  config.default_family_prefix = 'fa'
  config.default_replacement_class = 'svg-inline--fa'
end
```

The configuration option `source_type` was added to address the performance hit from loading large json files 
from the PRO collection and introduces several ways to include icons in the application.
 
1. `json` load a json file, traverse and find the icon
2. `raw` load a single svg file from the filesystem
3. `sprite` load an svg sprite and target the icon by using svg fragment identifiers 
4. `js` load one or more .js files according to the recommended way described at [svg-with-js](https://fontawesome.com/how-to-use/svg-with-js)

They all have pros and cons so choose the one that is right for you.
 
`json` a single file that contains everything however it will have a noticeable impact on performance when used with 
the PRO collection because of the file size but not so much with the free one or a reduced set.
In order to use copy the `fontawesome/advanced-options/metadata/icons.json` in `app/assets/javascripts/icons.json` 

`raw` requires to push in your codebase all 2.986 icons unless they are hosted in a CDN, AWS or just a different repo.   

with `sprite` you only need four files but they can only be served from public folder for the fragment identifier feature to work 
which makes them available for anyone to download whereas the `raw` ones are 'hidden' in the `vendor` folder. 

Read more about svg sprites in the [docs](https://fontawesome.com/how-to-use/svg-sprites) 
and [browser support](https://fontawesome.com/how-to-use/svg-sprites#browser-support)

`js` uses the recommended way from Font-Awesome however it introduces a rendering issue relating to turbolinks 
[more info](https://github.com/FortAwesome/Font-Awesome/issues/11924) 

However the paths to the icons can be configured and as long the parent folder with the style name i.e. `solid`, `regular`
and so on remains the same feel free to place anywhere you like and if possible share your solution !

It is best not to mix the `source_type` configurations if you decide to switch between two types make sure to keep only the
assets relating to that `source_type` in order to avoid manifestations of unexpected behavior.

At the same time feel free to create a pull request if you have another idea on how to include them
or create an issue requesting a missing feature.   


## Usage
All options from [additional-styling](https://fontawesome.com/how-to-use/svg-with-js#additional-styling) are supported with the exception of 
CSS Pseudo-elements.
 
A mapping for the properties has been introduced in an attempt to make them more readable and easier to remember

| Original property | Mapped property | Required | Original value     | Mapped value                 | Type    |
|-------------------|-----------------|----------|--------------------|------------------------------|---------|
| class             | style           | yes      | fas, far, fal, fab | solid, regular, light, brand | string  |
| class             | name            | yes      | fa-user            | user                         | string  |
| class             | fixed_width     | no       | fa-fw              | true                         | boolean |
| class             | spin            | no       | fa-spin            | true                         | boolean |
| class             | extra_class     | no       | N/A                | any custom css class         | string  |
| data-fa-transform | transform       | no       | grow-6             | grow-6                       | string  |
| data-fa-mask      | mask            | no       | fas fa-comment     | fas fa-comment               | string  |


The `style` and `name` are required params and the rest optional ones go into a Hash in any order they might occur.

Then just use them like this

      <%= faw_icon 'solid', 'magic' %>
      <%= faw_icon 'solid', 'star', {extra_class: 'active'} %>
      <%= faw_icon 'solid', 'user', {size: '10x'} %>
      <%= faw_icon 'light', 'info', {fixed_width: true} %>
      <%= faw_icon 'regular', 'sync', {spin: true} %>
      <%= faw_icon 'brand', 'android', {transform: 'grow-5'} %>
      
Bear in mind that the `brand` icons only come in one style called `brand`(!) 
and the rest come in three variations but not all are available in the free collection.
Find them all in the [gallery](https://fontawesome.com/icons?d=gallery)      
      
## Contributing

[Issues](https://github.com/alexwebgr/faw_icon/issues) and [pull requests](https://github.com/alexwebgr/faw_icon/pulls) are more than welcome. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FawIcon project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/alexwebgr/faw_icon/blob/master/CODE_OF_CONDUCT.md).
