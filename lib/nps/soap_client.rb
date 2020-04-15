require 'certifi'
require_relative 'services'
require_relative 'environments'
require_relative 'utils'
module Nps
  class SoapClient

    def initialize(conf)
      if conf.logger.nil?
        conf.logger = Logger.new(STDOUT)
      end

      if conf.log_level != Logger::DEBUG
        conf.logger.formatter = NpsFormatter.new
      end
      if conf.log_level == Logger::DEBUG and conf.environment == Nps::Environments::PRODUCTION_ENV
        raise LoggerException
      end

      if conf.environment.nil?
        raise MissingEnvironmentException
      end

      if conf.environment == Nps::Environments::CUSTOM_ENV and conf.custom_env_urls.nil?
        raise EmptyCustomUrlsWithCustomEnvException
      end

      if conf.custom_env_urls
        if conf.environment != Nps::Environments::CUSTOM_ENV
          raise WrongConfigurationException
        end

        if conf.custom_env_urls.length > Nps::Utils::MAX_CUSTOM_URLS
          raise MaxCustomUrlsException
        end

        if conf.custom_env_urls.kind_of?(Array) and conf.custom_env_urls.empty?
          raise EmptyCustomUrlsException
        end

        conf.custom_env_urls.each do |url|
          # if url =~ /\A#{URI::regexp}\z/
          #   raise InvalidUrlException.error_message_with_url url
          # end

          unless url_valid? url
            raise InvalidUrlException.error_message_with_url url
          end

          # unless valid_url_1? url
          #   raise InvalidUrlException.error_message_with_url url
          # end
        end
      end

      @key = conf.key
      @log = true
      @logger = conf.logger
      @wsdl = Nps::Environments::get_wsdl(conf.environment)
      @open_timeout = conf.o_timeout.nil? ? 5 : conf.o_timeout
      @read_timeout = conf.r_timeout.nil? ? 60 : conf.r_timeout
      @verify_ssl = conf.verify_ssl.nil? ? true : conf.verify_ssl
      @sanitize = conf.sanitize.nil? ? true : conf.sanitize
      @log_level = conf.log_level ? conf.log_level : nil
      @proxy = conf.proxy_url ? conf.proxy_url : nil
      @proxy_username = conf.proxy_username ? @proxy_username : nil
      @proxy_password = conf.proxy_password ? @proxy_password : nil
      @custom_env_urls = conf.custom_env_urls ? conf.custom_env_urls : nil

      setup
    end

    def url_valid?(url)
        url = URI.parse(url) rescue false
        url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
    end

    def valid_url_1?(url)
      uri = URI.parse(url)
      uri.is_a?(URI::HTTP) && !uri.host.nil?
    rescue URI::InvalidURIError
      false
    end

    def setup
      @client_config = {
          ssl_verify_mode: :none,
          logger: @logger,
          wsdl: File.join(File.dirname(File.expand_path(__FILE__)), "/wsdl/" + @wsdl),
          open_timeout: @open_timeout,
          read_timeout: @read_timeout,
          pretty_print_xml: true,
          log: @log
      }

      if @log_level
        lvl_config = {
          log_level: :debug
        }
        @client_config.merge!(lvl_config)
      end
      
      if @verify_ssl
        ssl_config = {
            ssl_verify_mode: :peer,
            ssl_ca_cert_file: Certifi.where
        }
        @client_config.merge!(ssl_config)
      end

      if @proxy
        proxy = {
            proxy: @proxy
        }
        @client_config.merge!(proxy)
      end

      if @proxy_username
        proxy_auth = {
          headers: { "Proxy-Authorization" => "Basic #{secret}" }
        }
        @client_config.merge!(proxy_auth)
      end

    end

    def add_secure_hash(params)
      concatenated_data = ""
      sorted_hash = params.sort_by{|x,y| x}.to_h
      sorted_hash.each { |key, value|
        if not value.is_a? ::Hash and not value.kind_of?(Array)
          concatenated_data = concatenated_data+value.to_s
        end
      }
      secure_hash = create_hmac_sha256(concatenated_data)
      params["psp_SecureHash"] = secure_hash
      return params
    end

    def create_md5_hash(data)
      return Digest::MD5.hexdigest(data)
    end

    def create_hmac_sha256(data)
      return OpenSSL::HMAC.hexdigest('sha256', @key, data)
    end

    def create_hmac_sha512(data)
      return OpenSSL::HMAC.hexdigest('sha512', @key, data)
    end

    def add_extra_data(params, service)
      services = Services.new()
      if services.is_service_in_services_with_additional_details(service)
        return params
      end
      info = {"SdkInfo" => Nps::Utils::SDK[:language] + ' SDK Version: ' + Nps::Version::VERSION}
      if params.key?("psp_MerchantAdditionalDetails")
        params["psp_MerchantAdditionalDetails"] = params["psp_MerchantAdditionalDetails"].merge(info)
      else
        params["psp_MerchantAdditionalDetails"] = info
      end
      return params
    end

    def soap_call(service, params)
      params = add_extra_data(params, service)
      if @sanitize
        params = Nps::Utils::sanitize(params)
      end
      unless params.has_key? 'psp_ClientSession'
        params = add_secure_hash(params)
      end 
      params = {"Requerimiento" => params}

        if @custom_env_urls
          internal_connection_timeout = @read_timeout
          @custom_env_urls.each do |url|
            begin
              start_time = Time.now
              @client_config.merge!({endpoint: url,
                                     open_timeout: Nps::Utils::CUSTOM_URL_CONNECTION_TIMEOUT,
                                     read_timeout: internal_connection_timeout})
              @client = Savon.client @client_config
              @client.call(service, message: params).body
              break
            rescue SocketError, HTTPClient::ConnectTimeoutError
	      if @custom_env_urls.last == url
      	        raise ApiException
	      end
	      @logger.warn("Could not connect to #{url}")
              finish_time = Time.now
              delta_time = finish_time - start_time
              internal_connection_timeout -= delta_time.ceil
              next
            rescue HTTPClient::ReceiveTimeoutError
              raise ApiException
            rescue StandardError 
              raise 'An unexpected error occurred'
            end
          end
        else
          begin
            @client = Savon.client @client_config
            @client.call(service, message: params).body
          rescue HTTPClient::ReceiveTimeoutError
           raise ApiException
          rescue StandardError 
           raise 'An unexpected error occurred'
         end
       end
    end
  end
end
