  method if_cts_abap_vcs_registry_hndlr~register_objects.
    data(body) = /ui2/cl_json=>serialize(
        data             = objects
        compress         = abap_true
        pretty_name      = abap_true
    ).

    data(action) = if_cts_abap_vcs_registry_hndlr=>co_action_register_objects.
    me->logger->log_start( action = action info = repository ).

    me->logger->log_info( action = action info = branch ).
    me->logger->log_info( action = action info = conv #( me->connection )  ).
    me->logger->log_info( action = action info = |Objects to be Added: { lines( objects ) } | ) ##NO_TEXT .
    loop at objects into data(ls_object).
      me->logger->log_info( action = action info = |Object Name: { ls_object-obj_name } | ) ##NO_TEXT .
    endloop.
    data(http_response) = me->client->post(
      exporting
        iv_path    = |/repository/{ escape( val = repository format = cl_abap_format=>e_url ) }/branches/{ escape( val = branch format = cl_abap_format=>e_xss_url ) }/objects|
*        iv_path    = |/repository/{ escape( val = repository format = cl_abap_format=>e_url ) }/{ escape( val = branch format = cl_abap_format=>e_url ) }/objects|
        ir_data    = body
            it_header = value #( ( field = if_cts_abap_vcs_registry_hndlr=>co_sap_username value = sy-uname ) )
        changing
            data = r_objects
    ).
    loop at r_objects into data(ls_r_object).
      me->logger->log_info( action = action info = |Object Name: { ls_r_object-ref-obj_name } | ) ##NO_TEXT .
      me->logger->log_info( action = action info = |Registration Code: { ls_r_object-code } | ) ##NO_TEXT .
      me->logger->log_info( action = action info = |Registration Message: { ls_r_object-message } | ) ##NO_TEXT .
    endloop.

    if http_response-exception is not initial.
      raise exception type cx_cts_abap_vcs_exception
        exporting
          textid             = cx_cts_abap_vcs_exception=>internal_error
          message_variable_1 = |{ http_response-exception }|. "#EC NOTEXT
    endif.

    me->logger->log_end( action = action ).
  endmethod.