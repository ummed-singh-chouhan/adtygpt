  method fileset_get_entity.

    try.
        data ls_message type scx_t100key.
        data(ls_key_rid) = it_key_tab[ name = co_key_fields-rid ].
        data(ls_key_prefix) = it_key_tab[ name = co_key_fields-prefix ].
        data(ls_key_file_identifier) = it_key_tab[ name = co_key_fields-file_identifier ].

        data ls_request type cl_cts_abap_vcs_file_facade=>ty_get_file_content_request.
        ls_request-prefix     = ls_key_prefix-value.
        ls_request-repository = ls_key_rid-value.
*       For the prefixes 'objects' and 'local' (-> aka 'tmp') the object type and the object name must be derived
        if ls_key_prefix-value eq if_cts_abap_vcs_file_handler=>co_prefix_objects or
           ls_key_prefix-value eq if_cts_abap_vcs_file_handler=>co_prefix_local.
*         Split the 'fileidentifier' into filename and path
          data(ls_file) = cl_cts_abap_vcs_file_handler=>if_cts_abap_vcs_file_handler~split_into_file_and_path( ls_key_file_identifier-value ).
*         Now derive the object type and the object name from the path
          data(ls_object) = cl_cts_abap_vcs_object_handler=>get_object_type_and_name( ls_file-path ).
          ls_request-object_type = ls_object-type.
          ls_request-object_name = ls_object-name.
          ls_request-file_name   = cl_http_client=>if_http_client~unescape_url( ls_file-name ).

          " Replace ~ to url encoded string %7E because the most browser will convert it to the proper character but this will lead to wrong file name
          ls_request-file_name = replace( val = ls_request-file_name sub = '~' with = '%7E' ).
          replace all occurrences of regex '\/' in ls_request-file_name with '%2F'.
        else.
*          ls_request-file_name   = cl_http_client=>if_http_client~unescape_url( ls_key_file_identifier-value ). "not needed
          ls_request-file_name   = ls_key_file_identifier-value.
        endif.

        data(ls_response) = cl_cts_abap_vcs_file_facade=>get_file_content( ls_request ).
        if ls_response-exception is not initial.
          raise exception type /iwbep/cx_mgw_busi_exception
            exporting
              message_unlimited = ls_response-exception.
        elseif ls_response-error_log is not initial.
          raise exception type /iwbep/cx_mgw_busi_exception
            exporting
              message_unlimited = me->get_error_log( ).
        else.
          er_entity-rid             = ls_key_rid-value.
          er_entity-prefix          = ls_key_prefix-value.
          er_entity-file_identifier = ls_key_file_identifier-value.
          er_entity-content         = ls_response-file_content.
          er_entity-encoding        = ls_response-file_encoding.
        endif.

      catch cx_cts_abap_vcs_exception into data(exc).
        raise exception type /iwbep/cx_mgw_busi_exception
          exporting
            previous          = exc
            message_unlimited = me->get_error_log( ).
    endtry.

  endmethod.