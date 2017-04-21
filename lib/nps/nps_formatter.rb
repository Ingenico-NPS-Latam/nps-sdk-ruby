require 'logger'

module Nps
  class NpsFormatter < Logger::Formatter

    def call(severity, time, progname, msg)
      msg = ofuscate(msg)
      "#{time} - #{severity} - NpsSDK - #{msg2str(msg)}"
    end

    def ofuscate_cvc(msg)
      msg.gsub(/>\d{3,4}<\/psp_CardSecurityCode>/) { |x| x.gsub(/\d{3,4}/) { |x| "*" * x.length}}
    end

    def ofuscate_card_number(msg)
      msg.gsub(/>\d{13,19}<\/psp_CardNumber>/) { |x| x.gsub(/\d{13,19}/) { |x|  x.slice(0,6) +  "*" * (x.length - 10) + x.slice(x.length - 4, x.length)} }
    end


    def ofuscate_card_exp_date(msg)
      msg.gsub(/>\d{4}<\/psp_CardExpDate>/) { |x| x.gsub(/\d{4}/) { |x| "*" * x.length} }
    end

    def ofuscate_token_cvc(msg)
      msg.gsub(/>\d{3,4}<\/SecurityCode>/) { |x| x.gsub(/\d{3,4}/) { |x| "*" * x.length}}
    end

    def ofuscate_token_card_number(msg)
      msg.gsub(/>\d{13,19}<\/Number>/) { |x| x.gsub(/\d{13,19}/) { |x|  x.slice(0,6) +  "*" * (x.length - 10) + x.slice(x.length - 4, x.length)} }
    end


    def ofuscate_token_card_exp_date(msg)
      msg.gsub(/>\d{4}<\/ExpirationDate>/) { |x| x.gsub(/\d{4}/) { |x| "*" * x.length} }
    end

    def ofuscate(msg)
      msg = ofuscate_card_exp_date(msg)
      msg = ofuscate_card_number(msg)
      msg = ofuscate_cvc(msg)
      msg = ofuscate_token_card_exp_date(msg)
      msg = ofuscate_token_card_number(msg)
      msg = ofuscate_token_cvc(msg)
    end
  end
end