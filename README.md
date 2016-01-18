# React::Rails::ViewHelperImplementation

This GEM requires react-rails 1.5.0 or higher!

## What problem it solves?

1. Size of inline props placed to the root component tag as attributes may be too huge to:
  1. Process in browser devtools. So that browser stucks trying to render markup for preview.
  2. Deliver it to user due to bandwidth (for highload apps).
2. Inline props placed to the attributes of tag are looking freaky because of its size and HTML safety.

So props we want to place:
```JSON
{"foo": "bar"}
```
are looking like this:
```HTML
{&quot;foo&quot;:&quot;bar&quot;}
```

##Solution
Moving inline props to the ```<script type="text/json">{"foo": "bar"}</script>``` will:

1. Reduce the size of data passed to the page in order to render component at the initial state. It's also useful because it reduces bandwidth utilization (even if we are using GZIP).
2. Allow browser inspector to operate on DOM faster.
3. Make markup looking more cleaner.

Placing inline props at the end of body speeds up DOM rendering and allows Turbolinks to load this data along with other markup on each request.

## How it works
`#react_component` method just renders another one `<script>` tag before the component root tag. This `<script>` tag contains JSON with initial data for the component.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'react-rails-view_helper_implementation', github: 'panasyuk/react-rails-view_helper_implementation'
```

And then execute:

    $ bundle

## Usage

Add following line to your Rails application config:
```
#config/application.rb
config.react.view_helper_implementation = React::Rails::ViewHelperImplementation
```

And then add following asset pipeline directive to your application.js instead of react_ujs:
```
/*= require react_ujs_with_separate_props
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/panasyuk/react-rails-view_helper_implementation. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

