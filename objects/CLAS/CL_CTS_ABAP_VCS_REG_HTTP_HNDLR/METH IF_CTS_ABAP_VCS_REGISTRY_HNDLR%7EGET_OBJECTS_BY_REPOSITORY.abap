  method if_cts_abap_vcs_registry_hndlr~get_objects_by_repository.
*    types: begin of ty_objects,
*             objects type if_cts_abap_vcs_registry_hndlr=>tt_object,
*           end of ty_objects.
*    data: lt_objects type ty_objects.

    data(action) = if_cts_abap_vcs_registry_hndlr=>co_action_get_obj_by_repo.
    me->logger->log_start( action = action info = |Repository: { repository } |  ) ##NO_TEXT.
    me->logger->log_info( action = action info = |Branch: { branch } |  ) ##NO_TEXT.
    me->logger->log_info( action = action info = conv #( me->connection )  ) ##NO_TEXT.
    data lv_endpoint type string.
    lv_endpoint = |/repository/{ escape( val = repository format = cl_abap_format=>e_url ) }/branches/{ escape( val = branch format = cl_abap_format=>e_xss_url )  }/objects|.


    data(http_response) = me->client->get(
        exporting
            iv_path    = lv_endpoint
            it_header = value #( ( field = if_cts_abap_vcs_registry_hndlr=>co_sap_username value = sy-uname ) )
        changing
            data = r_objects
    ).

    if http_response-exception is not initial.
      raise exception type cx_cts_abap_vcs_exception
        exporting
          textid             = cx_cts_abap_vcs_exception=>internal_error
          message_variable_1 = |{ http_response-exception }|. "#EC NOTEXT
    endif.

    me->logger->log_end( action = action ).

  endmethod.