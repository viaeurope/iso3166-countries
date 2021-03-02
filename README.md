# ISO3166::Countries

This gem is heavily inspired by [hexorx/countries](https://github.com/hexorx/countries). Due to lack of maintenance of the original gem, we decided to make our own gem based on iso.org data.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'iso3166-countries'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install iso3166-countries

## Usage

The gem is shipped with sample data that includes ISO3166 data for 3 countries(BR, CH and NZ). In order to access all countries data, you must purchase the XML data file from [iso.org](https://www.iso.org/).

```ruby
ISO3166::Countries.data_path = "path/to/data/file.xml"
country = ISO3166::Country.new("BR")
=> #<ISO3166::Country:0x00007f9253226d88 @code="BR" ...
country.alpha2
=> "BR"
country.alpha3
=> "BRA"
country.name
=> "Brazil" # English name
country.number
=> "076"
country.in_eu?
=> false

ISO3166::Country.find_by(alpha2: "BR")
=> #<ISO3166::Country:0x00007f9253226d88 @code="BR" ...
ISO3166::Country.find_by(alpha3: "BRA")
=> #<ISO3166::Country:0x00007f9253226d88 @code="BR" ...
ISO3166::Country.all_names_with_codes
=> [["BR", "Brazil"], ["CH", "Switzerland"], ["NZ", "New Zealand"], ["NL", "Netherlands (the)"]]

ISO3166::Country.find_by(alpha2: "BR") == ISO3166::Country["BR"]
=> true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/viaeurope/iso3166-countries.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
