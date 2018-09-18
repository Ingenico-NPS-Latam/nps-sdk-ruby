require 'savon'
require_relative 'services'
require 'digest'
require_relative 'soap_client'

module Nps

  class Sdk < SoapClient

    def pay_online_2p(params)
      soap_call(Services::PAY_ONLINE_2P, params)
    end

    def authorize_2p(params)
      soap_call(Services::AUTHORIZE_2P, params)
    end

    def pay_online_3p(params)
      soap_call(Services::PAY_ONLINE_3P, params)
    end

    def authorize_3p(params)
      soap_call(Services::AUTHORIZE_3P, params)
    end

    def split_pay_online_3p(params)
      soap_call(Services::SPLIT_PAY_ONLINE_3P, params)
    end

    def split_authorize_3p(params)
      soap_call(Services::SPLIT_AUTHORIZE_3P, params)
    end

    def cash_payment_3p(params)
      soap_call(Services::CASH_PAYMENT_3P, params)
    end

    def bank_payment_3p(params)
      soap_call(Services::BANK_PAYMENT_3P, params)
    end

    def bank_payment_2p(params)
      soap_call(Services::BANK_PAYMENT_2P, params)
    end

    def capture(params)
      soap_call(Services::CAPTURE, params)
    end

    def refund(params)
      soap_call(Services::REFUND, params)
    end

    def simple_query_tx(params)
      soap_call(Services::SIMPLE_QUERY_TX, params)
    end

    def query_txs(params)
      soap_call(Services::QUERY_TXS, params)
    end

    def change_secret_key(params)
      soap_call(Services::CHANGE_SECRET_KEY, params)
    end

    def fraud_screening(params)
      soap_call(Services::FRAUD_SCREENING, params)
    end

    def notify_fraud_screening_review(params)
      soap_call(Services::NOTIFY_FRAUD_SCREENING_REVIEW, params)
    end

    def get_iin_details(params)
      soap_call(Services::GET_IIN_DETAILS, params)
    end

    def query_card_number(params)
      soap_call(Services::QUERY_CARD_NUMBER, params)
    end

    def create_payment_method(params)
      soap_call(Services::CREATE_PAYMENT_METHOD, params)
    end

    def create_payment_method_from_payment(params)
      soap_call(Services::CREATE_PAYMENT_METHOD_FROM_PAYMENT, params)
    end

    def retrieve_payment_method(params)
      soap_call(Services::RETRIEVE_PAYMENT_METHOD, params)
    end

    def update_payment_method(params)
      soap_call(Services::UPDATE_PAYMENT_METHOD, params)
    end

    def delete_payment_method(params)
      soap_call(Services::DELETE_PAYMENT_METHOD, params)
    end

    def create_customer(params)
      soap_call(Services::CREATE_CUSTOMER, params)
    end

    def retrieve_customer(params)
      soap_call(Services::RETRIEVE_CUSTOMER, params)
    end

    def update_customer(params)
      soap_call(Services::UPDATE_CUSTOMER, params)
    end

    def delete_customer(params)
      soap_call(Services::DELETE_CUSTOMER, params)
    end

    def recache_payment_method_token(params)
      soap_call(Services::RECACHE_PAYMENT_METHOD_TOKEN, params)
    end

    def create_payment_method_token(params)
      soap_call(Services::CREATE_PAYMENT_METHOD_TOKEN, params)
    end

    def retrieve_payment_method_token(params)
      soap_call(Services::RETRIEVE_PAYMENT_METHOD_TOKEN, params)
    end

    def create_client_session(params)
      soap_call(Services::CREATE_CLIENT_SESSION, params)
    end

    def get_installments_options(params)
      soap_call(Services::GET_INSTALLMENTS_OPTIONS, params)
    end

    def split_pay_online_2p(params)
      soap_call(Services::SPLIT_PAY_ONLINE_2P, params)
    end

    def split_authorize_2p(params)
      soap_call(Services::SPLIT_AUTHORIZE_2P, params)
    end

    def query_card_details(params)
      soap_call(Services::QUERY_CARD_DETAILS, params)
    end

  end
end