# FixerUpper

[![Build Status](https://travis-ci.org/zachahn/fixer_upper.svg?branch=master)](https://travis-ci.org/zachahn/fixer_upper)

You have a file and it just has so much potential.

Gut job or not, FixerUpper makes that file into the result of your dreams,
backsplash, shiplap, and all.


## Usage

FixerUpper is a wrapper around Tilt template engines.

It requires explicit registration of template engines:

```ruby
fixer_upper = FixerUpper.new
fixer_upper.register_tilt("erb", engine: Tilt::ERBTemplate)

renderer = fixer_upper.renderer(filename: "file.erb", content: %(<%= 1 + 1 %>))
renderer.call # => "2"
```

It allows for setting "global" options.

```ruby
fixer_upper = FixerUpper.new
fixer_upper.register_tilt("csv", engine: Tilt::CSVTemplate,
  options: { col_sep: "|" }
)

template = %(csv << ["hello", "world"])

renderer = fixer_upper.renderer(filename: "file.csv", content: template)
renderer.call # => "hello|world\n"
```

It works with non-tilt templates as well

```ruby
class Upcase
  def initialize(_filename, memo)
    @memo = memo
  end

  def render(_view_scope, &block)
    @memo.upcase
  end
end

fixer_upper = FixerUpper.new
fixer_upper.register("upcase", engine: Upcase)

renderer = fixer_upper.renderer(filename: "file.upcase", content: "hi")
renderer.call # => "HI"
```


## Installation

Add this line to your application's Gemfile:

```ruby
gem "fixer_upper"
```

And then execute:

    $ bundle


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake test` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org][gem].


## Contributing

Bug reports and pull requests are welcome on GitHub at
[https://github.com/zachahn/fixer_upper][git].


## License

The gem is available as open source under the terms of the [MIT
License][license].


[gem]: https://rubygems.org
[git]: https://github.com/zachahn/fixer_upper
[license]: http://opensource.org/licenses/MIT
