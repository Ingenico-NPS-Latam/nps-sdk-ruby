Gem::Specification.new do |s|
  s.name        = 'nps_sdk'
  s.version     = '1.1.11'
  s.date        = '2016-11-30'
  s.summary     = "SDK!"
  s.description = "Ruby SDK for NPS Services"
  s.authors     = ["soporte@nps.com.ar"]
  s.email       = 'soporte@nps.com.ar'
  s.add_runtime_dependency 'savon', '~> 2.11'
  s.files       = ["lib/nps_sdk.rb",
                   "lib/nps/sdk.rb",
                   "lib/nps/nps_formatter.rb",
                   "lib/nps/services.rb",
                   "lib/nps/environments.rb",
                   "lib/nps/configuration.rb",
                   "lib/nps/api_exception.rb",
                   "lib/nps/utils.rb",
                   "lib/nps/soap_client.rb",
                   "lib/nps/wsdl/staging.wsdl",
                   "lib/nps/wsdl/sandbox.wsdl",
                   "lib/nps/wsdl/production.wsdl",
                   "lib/nps/wsdl/development.wsdl",
                   "lib/nps/conf/sanitize_struc.ini"]
  s.license       = 'MIT'
end
