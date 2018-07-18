require 'certifi'
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

      @key = conf.key
      @log = true
      @logger = conf.logger
      @wsdl = conf.environment
      @open_timeout = conf.o_timeout.nil? ? 5 : conf.o_timeout
      @read_timeout = conf.r_timeout.nil? ? 60 : conf.r_timeout
      @verify_ssl = conf.verify_ssl.nil? ? true : conf.verify_ssl
      @sanitize = conf.sanitize.nil? ? true : conf.sanitize
      @log_level = conf.log_level ? conf.log_level : nil
      @proxy = conf.proxy_url ? conf.proxy_url : nil
      @proxy_username = conf.proxy_username ? @proxy_username : nil
      @proxy_password = conf.proxy_password ? @proxy_password : nil

      setup
    end

    def setup
      client_config = {
          ssl_verify_mode: :none,
          wsdl: File.join(File.dirname(File.expand_path(__FILE__)), "/wsdl/" + @wsdl),
          logger: @logger,
          open_timeout: @open_timeout,
          read_timeout: @read_timeout,
          pretty_print_xml: true,
          log: @log
      }

      if @log_level
        lvl_config = {
          log_level: :debug
        }
        client_config.merge!(lvl_config)
      end
      
      if @verify_ssl
        ssl_config = {
            ssl_verify_mode: :peer,
            ssl_ca_cert_file: Certifi.where
        }
        client_config.merge!(ssl_config)
      end

      if @proxy
        proxy = {
            proxy: @proxy
        }
        client_config.merge!(proxy)
      end

      if @proxy_username
        proxy_auth = {
          headers: { "Proxy-Authorization" => "Basic #{secret}" }
        }
        client_config.merge!(proxy_auth)
      end


      @client = Savon.client client_config

    end

    def add_secure_hash(params)
      concatenated_data = ""
      sorted_hash = params.sort_by{|x,y| x}.to_h
      sorted_hash.each { |key, value|
        if not value.is_a? ::Hash and not value.kind_of?(Array)
          concatenated_data = concatenated_data+value.to_s
        end
      }
      concatenated_data = concatenated_data+@key
      hashed_string = Digest::MD5.hexdigest(concatenated_data)
      params["psp_SecureHash"] = hashed_string
      return params
    end

    def add_extra_data(params)
      info = {"SdkInfo" => Nps::Utils::SDK[:language] + ' SDK Version: ' + Nps::Version::VERSION}
      if params.key?("psp_MerchantAdditionalDetails")
        params["psp_MerchantAdditionalDetails"] = params["psp_MerchantAdditionalDetails"].merge(info)
      else
        params["psp_MerchantAdditionalDetails"] = info
      end
      return params
    end

    def soap_call(service, params)
      params = add_extra_data(params)
      if @sanitize
        params = Nps::Utils::sanitize(params)
      end
      unless params.has_key? 'psp_ClientSession'
        params = add_secure_hash(params)
      end 
      params = {"Requerimiento" => params}
      begin
        @client.call(service, message: params).body
      rescue TimeoutError
        raise ApiException
      end
    end
  end
end
