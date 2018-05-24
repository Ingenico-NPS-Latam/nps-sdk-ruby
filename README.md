#  Ruby SDK
 

## Availability
Supports Ruby 2.3 and above


## How to install

```shell_session
$ gem install nps_sdk
```

## Configuration

It's a basic configuration of the SDK

```ruby
require 'nps_sdk'
conf = Nps::Configuration.new
conf.environment =Nps::Environments::SANDBOX_ENV
conf.key = "Secret key"
```

Here is an simple example request:

```ruby
require 'nps_sdk'
conf = Nps::Configuration.new
conf.environment =Nps::Environments::SANDBOX_ENV
conf.key = "Secret key"

npssdk = Nps::Sdk.new(conf)

params = {
    'psp_Version'          => '2.2',
    'psp_MerchantId'       => 'psp_test',
    'psp_TxSource'         => 'WEB',
    'psp_MerchTxRef'       => 'ORDER5rf666-3',
    'psp_MerchOrderId'     => 'ORDER5rf666',
    'psp_Amount'           => '1000',
    'psp_NumPayments'      => '1',
    'psp_Currency'         => '032',
    'psp_Country'          => 'ARG',
    'psp_Product'          => '14',
    'psp_CustomerMail'     => 'john.doe@example.com',
    'psp_CardNumber'       => '4507990000000010',
    'psp_CardExpDate'      => '1903',
    'psp_CardSecurityCode' => '306',
    'psp_SoftDescriptor'   => 'Sol Tropical E',
    'psp_PosDateTime'      => '2016-12-01 12:00:00'
}

begin
  resp = npssdk.authorize_2p(params)
rescue => e
  #Code to handle the error
end
```

## Environments

```ruby
require 'nps_sdk'
conf = Nps::Configuration.new
conf.environment = Nps::Environments::SANDBOX_ENV
conf.environment = Nps::Environments::STAGING_ENV
conf.environment = Nps::Environments::PRODUCTION_ENV
```

## Error handling

ApiException: This exception is raised when a ReadTimeout or a ConnectTimeout occurs.

Note: The rest of the exceptions that can occur will be detailed inside of the response provided by NPS or will be provided by savon2.

```ruby
npssdk = Nps::Sdk.new(conf)

#Code
begin
  #Code or sdk call
rescue => e
  puts e.message
end
```

## Advanced configurations

Nps SDK allows you to log what’s happening with you request inside of our SDK, it logs by default to stout.
The SDK uses the custom logger that you use for your project.

```ruby
require 'nps_sdk'
require 'logger'

conf = Nps::Configuration.new
conf.logger = Logger.new(STDOUT)
conf.key = "Secret key"
```

The logging.INFO level will write concise information of the request and will mask sensitive data of the request. 
The logging.DEBUG level will write information about the request to let developers debug it in a more detailed way.

```ruby
require 'nps_sdk'
require 'logger'

conf = Nps::Configuration.new
conf.key = "Secret key"
conf.logger = Logger.new(STDOUT)
conf.log_level = Logger::DEBUG
```

Sanitize allows the SDK to truncate to a fixed size some fields that could make request fail, like extremely long name.

```ruby
require 'nps_sdk'
conf = Nps::Configuration.new
conf.key = "Secret key"
conf.sanitize = true
```

you can change the timeout of the request.

```ruby
require 'nps_sdk'
conf = Nps::Configuration.new
conf.key = "Secret key"
conf.sanitize = true
```

Proxy configuration

```ruby
require 'nps_sdk'
conf = Nps::Configuration.new
conf.key = "Secret key"
conf.proxy_url = "YOUR/PROXY/URL"
conf.proxy_username = "USERNAME"
conf.proxy_password = "YOUR_PASSWORD"
```