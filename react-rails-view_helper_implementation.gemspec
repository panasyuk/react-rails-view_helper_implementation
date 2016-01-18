# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'react/rails/view_helper_implementation/version'

Gem::Specification.new do |spec|
  spec.name          = "react-rails-view_helper_implementation"
  spec.version       = React::Rails::ViewHelperImplementation::VERSION
  spec.authors       = ["Alexander Panasyuk"]
  spec.email         = ["panasmeister@gmail.com"]

  spec.summary       = %q{ An alternative implementation of the #react_component view helper method. }
  spec.description   = <<-DESC
This GEM provides more lightweight implementation of the React::Rails::ComponentMount#react_component.
What problem it solves?
Size of inline props placed to the root component tag as attributes may be too huge to:
1.1 Process in browser devtools. So that browser stucks trying to render markup for preview.
1.2 Deliver it to user due to bandwidth (for highload apps).
Inline props placed to the attributes of tag are looking freaky because of its size and HTML safety.
So props we want to place:
{"foo": "bar"}
are looking like this:
{&quot;foo&quot;:&quot;bar&quot;}
This GEM reduces the size of component's initial JSON data by moving this data from the component tag attribute
to a separate <script> tag.
Moving inline props to the <script type="text/json">{"foo": "bar"}</script> will:
1. Reduce the size of data passed to the page in order to render component at the initial state.
It's also useful because it reduces bandwidth utilization (even if we are using GZIP).
2. Allow browser inspector to operate on DOM faster.
3. Make markup looking more cleaner.
Placing inline props at the end of body speeds up DOM rendering and allows Turbolinks to load this data
along with other markup on each request.
DESC

  spec.homepage      = "https://github.com/panasyuk/react-rails-view_helper_implementation"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = " Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  # spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_dependency "react-rails", "~> 1.5.0"
end
