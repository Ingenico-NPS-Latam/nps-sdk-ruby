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