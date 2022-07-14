  method if_cts_abap_vcs_registry_hndlr~delete_object.
    data: lv_object type if_cts_abap_vcs_registry_hndlr=>ty_object.


    data: ls_body type ref to data.

    get reference of object into ls_body.
    data(action) = if_cts_abap_vcs_registry_hndlr=>co_action_delete_object.
    me->logger->log_start( action = action info = |Repository: { repository } | ) ##NO_TEXT.
    me->logger->log_info( action = action info = conv #( me->connection )  ) ##NO_TEXT.
    me->logger->log_info( action = action info = |Branch: { branch } |  ) ##NO_TEXT.
    me->logger->log_info( action = action info = |Delete object name: { object-obj_name } | ) ##NO_TEXT.
    if object-keys is not initial.
      loop at object-keys into data(ls_key).
        me->logger->log_info( action = action info = |Delete object keys tabname: { ls_key-tabname } | ) ##NO_TEXT.
        loop at ls_key-columns into data(ls_column).
          me->logger->log_info( action = action info = |Delete object column key: { ls_column-field } value: { ls_column-value }| ) ##NO_TEXT.
        endloop.
      endloop.
    endif.
    data(http_response) = me->client->delete(
        exporting
            iv_path    = |/repository/{ escape( val = repository format = cl_abap_format=>e_url ) }/branches/{ escape( val = branch format = cl_abap_format=>e_xss_url ) }/objects|
            ir_data    = ls_body
            it_header = value #( ( field = if_cts_abap_vcs_registry_hndlr=>co_sap_username value = sy-uname ) )
        changing
            data = lv_object
    ).
    if http_response-exception is not initial.
      raise exception type cx_cts_abap_vcs_exception
        exporting
          textid             = cx_cts_abap_vcs_exception=>internal_error
          message_variable_1 = |{ http_response-exception }|. "#EC NOTEXT
    endif.
    me->logger->log_end( action = action ).
  endmethod.