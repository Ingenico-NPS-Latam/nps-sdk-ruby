module Nps
  class Environments
    PRODUCTION_ENV = 0
    SANDBOX_ENV = 1
    STAGING_ENV = 2
    DEVELOPMENT_ENV = 3
    CUSTOM_ENV = 4

    SANDBOX_WSDL = "sandbox.wsdl"
    STAGING_WSDL = "staging.wsdl"
    PRODUCTION_WSDL = "production.wsdl"
    DEVELOPMENT_WSDL = "development.wsdl"
    CUSTOM_WSDL = "production.wsdl"

    private_constant :SANDBOX_WSDL
    private_constant :STAGING_WSDL
    private_constant :PRODUCTION_WSDL
    private_constant :DEVELOPMENT_WSDL
    private_constant :CUSTOM_WSDL

    def self.get_wsdl (environment)
      begin
        if environment < 0
          raise "Invalid environment"
        end
        environments = [
            PRODUCTION_WSDL,
            STAGING_WSDL,
            SANDBOX_WSDL,
            DEVELOPMENT_WSDL,
            CUSTOM_WSDL
        ]
        return environments[environment]
      rescue
        raise "Environment not found"
      end
    end

  end
end
