class ApiException < StandardError
  def message
    "El tiempo de ejecución há expirado"
  end
end

class LoggerException < StandardError
  def message
    "DEBUG level is now allowed in PRODUCTION ENVIRONMENT"
  end
end

class EmptyCustomUrlsException < StandardError
  def message
    "CustomUrls cannot by empty"
  end
end

class InvalidUrlException < StandardError
  def message
    "Invalid URL"
  end

  def self.error_message_with_url (url)
    "Invalid URL - #{url}"
  end
end

class WrongConfigurationException < StandardError
  def message
    "Only CUSTOM_ENV environment is available with CustomUrls"
  end
end

class MissingEnvironmentException < StandardError
  def message
    "Environment field not specified"
  end
end

class MaxCustomUrlsException < StandardError
  def message
    "Custom Urls must contain at most 2 urls"
  end
end

class EmptyCustomUrlsWithCustomEnvException < StandardError
  def message
    "CustomEnvUrls cannot be empty using CUSTOM_ENV environment"
  end
end