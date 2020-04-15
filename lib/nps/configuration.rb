module Nps
  class Configuration
    attr_accessor :logger
    attr_accessor :log_level
    attr_accessor :key
    attr_accessor :environment
    attr_accessor :log
    attr_accessor :o_timeout
    attr_accessor :r_timeout
    attr_accessor :sanitize
    attr_accessor :verify_ssl
    attr_accessor :cert_file
    attr_accessor :key_file
    attr_accessor :proxy_url
    attr_accessor :proxy_username
    attr_accessor :proxy_password
    attr_accessor :custom_env_urls

  end
end