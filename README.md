[![Gem Version](https://badge.fury.io/rb/cnab150.svg)](https://badge.fury.io/rb/cnab150)
[![Build Status](https://travis-ci.org/marcomoura/cnab150.svg)](https://travis-ci.org/marcomoura/cnab150)
[![Coverage Status](https://coveralls.io/repos/marcomoura/cnab150/badge.svg?branch=master&service=github)](https://coveralls.io/github/marcomoura/cnab150?branch=master)
[![Code Climate](https://codeclimate.com/repos/562fd3b8e30ba04a3a00025f/badges/13ce3a3234d50e80222e/gpa.svg)](https://codeclimate.com/repos/562fd3b8e30ba04a3a00025f/feed)
[![Inline docs](http://inch-ci.org/github/marcomoura/cnab150.svg?branch=master)](http://inch-ci.org/github/marcomoura/cnab150)
[![Dependency Status](https://gemnasium.com/marcomoura/cnab150.svg)](https://gemnasium.com/marcomoura/cnab150)


# Cnab150

Client of cnab-150 return file.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cnab150'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cnab150

## Usage

* The examples are using these registries

```
 string_cnab150 = ['A20000111111111       PREF MUN XXXXXX-XYZ 341BANCO ITAU S.A.     2015101600131203                                                                     ',
                   'G982300210019        20151015201510168166000000005092477201510160000000000000007500000000050900000803120000701594   2                                 ',
                   'G982300210019        20151015201510168169000000023012477201510310201200230228200100000000230100000803120001183477   2                                 ',
                   'Z00000400000000001533612                                                                                                                              ']

```

* The parser_registries method needs an array os strings, it'll return an array of Cnab150::Registry
```
> registries = Cnab150.parse_registries(string_cnab150)
 => [ Cnab150::Registry, Cnab150::Registry, Cnab150::Registry, Cnab150::Registry ]
```

* To select a kind of registry, call the select method with the type and an array os strings
```
> g_registries = Cnab150.select(:g, string_cnab150)
 => [
       { registry_code: 'G',
         account: '982300210019',
         payment_date: '20151015',
         credit_date: '20151016',
         barcode: '81660000000050924772015101600000000000000075',
         value: '000000000509',
         service_value: '0000080',
         registry_number: '31200007',
         agency: '0159',
         channel: '4',
         authentication: '   2',
         payment_type: '',
         filler: '' },
       { registry_code: 'G',
         account: '982300210019',
         payment_date: '20151015',
         credit_date: '20151016',
         barcode: '81690000000230124772015103102012002302282001',
         value: '000000002301',
         service_value: '0000080',
         registry_number: '31200011',
         agency: '8347',
         channel: '7',
         authentication: '   2',
         payment_type: '',
         filler: '' },
    ]
```

* There is methods to select just the Header, Trailer and Details registries This method will return a Cnab150::Registry. The detail method return any other registries diferent from Header and Trailer

```
> h = Cnab150.header(registries)

> h.registry_code
 => 'A'

> h.registry_type
 => '2'
```


* To change the keys to hash
```
> h = Cnab150.header(registries)
> h.to_hash
 => {:registry_code=>"A",
     :registry_type=>"2",
     :agreement=>"0000111111111",
     :organization=>"PREF MUN XXXXXX-XYZ",
     :bank_code=>"341",
     :bank_name=>"BANCO ITAU S.A.",
     :file_date=>"20151016",
     :file_number=>"001312",
     :version=>"03",
     :service=>"",
     :filler=>""}
```

* To create a new layout add a YML file with the column names and positions

```
cnab150:
  a:
    registry_code: 1
    registry_type: 1
    agreement: 20
    organization: 20
    bank_code: 3
    bank_name: 20
    file_date: 8
    file_number: 6
    version: 2
    service: 17
    filler: 52
```
And override the default layout by setting the layout_path_file in the configure

```
Cnab150.configure do |config|
  config.layout_file_path = 'absolute/path/to/your/layout.yml'
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/marcomoura/cnab150.

