# FawIcon

### Minimalistic ruby gem that exposes a tag helper for Font Awesome icon sets.

By design only the svg-with-js version is supported following the recommendations from the font-awesome docs 
https://fontawesome.com/get-started/svg-with-js.

Another great feature is that is does not bundle any icons making it super fast to download and install 
as well as providing the ability to use new icons as they become available custom ones or the PRO collection.       

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'faw_icon'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install faw_icon
    
You will need to download and include in your application.js the desired .js files from [Font Awesome](https://fontawesome.com/get-started/svg-with-js)
where you can choose to include all or only a subset of them either the free ones or the PRO collections

application.js

     //= require fontawesome-all.min
     
## Usage
All options from [additional-styling](https://fontawesome.com/how-to-use/svg-with-js#additional-styling) are supported with the exception of 
CSS Pseudo-elements as being informed by the documentation.
 
A mapping for the properties has been introduced in an attempt to make them more readable and easier to remember

| Original property | Mapped property | Required | Original value     | Mapped value                 | Type    |
|-------------------|-----------------|----------|--------------------|------------------------------|---------|
| class             | style           | yes      | fas, far, fal, fab | solid, regular, light, brand | string  |
| class             | name            | yes      | fa-user            | user                         | string  |
| class             | fixed_width     | no       | fa-fw              | true                         | boolean |
| class             | spin            | no       | fa-spin            | true                         | boolean |
| data-fa-transform | transform       | no       | grow-6             | grow-6                       | string  |
| data-fa-mask      | mask            | no       | fas fa-comment     | fas fa-comment               | string  |


The `style` and `name` are required params and the rest optional ones go into a Hash in any order they might occur 
Then just use them like this

      <%= faw_icon 'solid', 'magic' %>
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
