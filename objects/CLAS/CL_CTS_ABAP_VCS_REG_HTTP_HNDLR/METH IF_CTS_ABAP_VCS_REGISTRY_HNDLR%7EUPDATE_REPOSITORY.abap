  method if_cts_abap_vcs_registry_hndlr~update_repository.



    data: ls_body type ref to data.

    get reference of update_repo_info into ls_body.
    data(action) = if_cts_abap_vcs_registry_hndlr=>co_action_update_repository.
    me->logger->log_start( action = action ).
    me->logger->log_info( action = action info = conv #( me->connection )  ).
    me->logger->log_info( action = action info = id ).
*    me->logger->log_info( action = action info = |Update Repo info id: { update_repo_info-id } url: { update_repo_info-url } | ) ##NO_TEXT.
    me->logger->log_info( action = action info = |type: { update_repo_info-type }| ) ##NO_TEXT.
    data(http_response) = me->client->put(
      exporting
        iv_path    = |/repository/{ escape( val = id format = cl_abap_format=>e_url ) }|
        ir_data    = ls_body
            it_header = value #( ( field = if_cts_abap_vcs_registry_hndlr=>co_sap_username value = sy-uname ) )
        changing
            data = repository
    ).

    if http_response-exception is not initial.
      raise exception type cx_cts_abap_vcs_exception
        exporting
          textid             = cx_cts_abap_vcs_exception=>internal_error
          message_variable_1 = |{ http_response-exception }|. "#EC NOTEXT
    endif.
    me->logger->log_end( action = action ).
  endmethod.