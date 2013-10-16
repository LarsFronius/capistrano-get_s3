# Capistrano::Get::S3

gets codebase as a tar.gz from s3 and allows you to deploy from that.

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-get-s3'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-get-s3

## Usage

Just add following to your deploy.rb
```
set :scm, :get_s3
set :aws_access_key_id, 'foo'
set :aws_secret_access_key, 'bar'
set :filename, 'my-codebase.tar.gz'
set :bucket, 'codebase-bucket'
set :bucket_region, 'EU'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
