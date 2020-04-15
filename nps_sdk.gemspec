Gem::Specification.new do |s|
  s.name        = 'nps_sdk'
  s.version     = '1.3.0'
  s.date        = '2018-03-12'
  s.summary     = "SDK!"
  s.description = "Ruby SDK for NPS Services"
  s.authors     = ["merchantservices@ingenico.com"]
  s.email       = 'merchantservices@ingenico.com'
  s.add_runtime_dependency 'savon', '~> 2.11'
  s.add_runtime_dependency 'httpclient', '~> 2.7.1'
  s.add_runtime_dependency 'certifi', '~> 2018.1', '>= 2018.01.18'
  s.add_runtime_dependency 'inifile', '~> 3.0'
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
                   "lib/nps/version.rb",
                   "lib/nps/conf/sanitize_struc.ini"]
  s.license       = 'MIT'
end
