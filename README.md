# FixerUpper

You have a file and it just has so much potential.

Gut job or not, FixerUpper makes that file into the result of your dreams,
backsplash, shiplap, and all.


## Installation

Add this line to your application's Gemfile:

```ruby
gem "fixer_upper"
```

And then execute:

    $ bundle


## Usage

```ruby
class FixerUpperCmark
  def call(text)
    CommonMarker.render_html(text, :DEFAULT)
  end
end

fixer_upper = FixerUpper.new
fixer_upper["md"] = FixerUpperCmark.new

fixer_upper.renovate("file.md")
# OR
fixer_upper.diy("**text**", "md")
```


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
