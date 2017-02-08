module Nps
  class Utils
    SDK = {language: 'Ruby', version: RUBY_VERSION}
    API_VERSION = {version: '2.2'}
    CACHE_TTL = 1
    TIMEOUT = 90


    def self.sanitize(params)
      #File.join(File.dirname(File.expand_path(__FILE__)), "/wsdl/" + @wsdl)
      myini = IniFile.load(File.join(File.dirname(File.expand_path(__FILE__)), "conf/sanitize_struc.ini"))
      return check_sanitize(params, true, nil, myini)
    end

    def self.check_sanitize(params, is_root, nodo, file)
      if is_root
        result_params = {}
      else
        result_params = params
      end
      params.each do |k, v|
        if v.is_a?(Hash)
          result_params[k] = check_sanitize(v, false, k, file)
        elsif v.is_a?(Array)
          result_params[k] = check_sanitize_array(v, k, file)
        else
          result_params[k] = validate_size(v, k, nodo, file)
        end
      end
      return result_params
    end

    def self.check_sanitize_array(params, nodo, file)
      result_params = []
      params.each { |x| result_params.push(check_sanitize(x, false, nodo, file)) }
      return result_params

    end

    def self.validate_size(value, k, nodo, file)
      if nodo != nil
        key_name = nodo.to_s + "." + k + ".max_length"
      else
        key_name = k + ".max_length"
      end
      size = file["global"][key_name]
      if size.nil?
        return value
      end
      return value.to_s.slice(0,size)
    end

  end
end