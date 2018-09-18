class Services

  PAY_ONLINE_2P=:pay_on_line_2p
  AUTHORIZE_2P=:authorize_2p
  PAY_ONLINE_3P=:pay_on_line_3p
  AUTHORIZE_3P=:authorize_3p
  SPLIT_PAY_ONLINE_3P=:split_pay_on_line_3p
  SPLIT_PAY_ONLINE_2P=:split_pay_on_line_2p
  SPLIT_AUTHORIZE_3P=:split_authorize_3p
  SPLIT_AUTHORIZE_2P=:split_authorize_2p
  CASH_PAYMENT_3P=:cash_payment_3p
  BANK_PAYMENT_2P=:bank_payment_2p
  BANK_PAYMENT_3P=:bank_payment_3p
  CAPTURE=:capture
  REFUND=:refund
  SIMPLE_QUERY_TX=:simple_query_tx
  QUERY_TXS=:query_txs
  CHANGE_SECRET_KEY=:change_secret_key
  FRAUD_SCREENING=:fraud_screening
  NOTIFY_FRAUD_SCREENING_REVIEW=:notify_fraud_screening_review
  GET_IIN_DETAILS=:get_iin_details
  QUERY_CARD_NUMBER=:query_card_number
  QUERY_CARD_DETAILS=:query_card_details
  CREATE_PAYMENT_METHOD = :create_payment_method
  CREATE_PAYMENT_METHOD_FROM_PAYMENT =:create_payment_method_from_payment
  RETRIEVE_PAYMENT_METHOD =:retrieve_payment_method
  UPDATE_PAYMENT_METHOD =:update_payment_method
  DELETE_PAYMENT_METHOD =:delete_payment_method
  CREATE_CUSTOMER =:create_customer
  RETRIEVE_CUSTOMER =:retrieve_customer
  UPDATE_CUSTOMER =:update_customer
  DELETE_CUSTOMER =:delete_customer
  RECACHE_PAYMENT_METHOD_TOKEN=:recache_payment_method_token
  CREATE_PAYMENT_METHOD_TOKEN=:create_payment_method_token
  RETRIEVE_PAYMENT_METHOD_TOKEN=:retrieve_payment_method_token
  CREATE_CLIENT_SESSION=:create_client_session
  GET_INSTALLMENTS_OPTIONS=:get_installments_options


  def is_service_in_services_with_additional_details(service)

    get_merch_det_not_add_services = [
            QUERY_TXS,
            REFUND,
            SIMPLE_QUERY_TX,
            CAPTURE,
            CHANGE_SECRET_KEY,
            NOTIFY_FRAUD_SCREENING_REVIEW,
            GET_IIN_DETAILS,
            QUERY_CARD_NUMBER,
            CREATE_PAYMENT_METHOD,
            CREATE_PAYMENT_METHOD_FROM_PAYMENT,
            RETRIEVE_PAYMENT_METHOD,
            UPDATE_PAYMENT_METHOD,
            DELETE_PAYMENT_METHOD,
            CREATE_CUSTOMER,
            RETRIEVE_CUSTOMER,
            UPDATE_CUSTOMER,
            DELETE_CUSTOMER,
            RECACHE_PAYMENT_METHOD_TOKEN,
            CREATE_PAYMENT_METHOD_TOKEN,
            RETRIEVE_PAYMENT_METHOD_TOKEN,
            CREATE_CLIENT_SESSION,
            GET_INSTALLMENTS_OPTIONS,
            QUERY_CARD_DETAILS
    ]

    return get_merch_det_not_add_services.include? service
  end

end


