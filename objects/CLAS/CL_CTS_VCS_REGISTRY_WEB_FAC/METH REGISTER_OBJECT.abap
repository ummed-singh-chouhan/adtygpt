  method register_object.

    data: ls_request type cl_cts_abap_vcs_registry_fac=>ty_register_objects_request.
    data: ls_response type cl_cts_abap_vcs_registry_fac=>ty_register_objects_response.

    /ui2/cl_json=>deserialize(
       exporting
         json = request
         pretty_name = 'X'
       changing
         data = ls_request
     ).

    data(lv_unescape_branch) = cl_http_utility=>unescape_url( branch ).
    ls_response = cl_cts_abap_vcs_registry_fac=>register_objects( repository = conv #( repository ) branch = lv_unescape_branch objects = ls_request ).

    response-code = prepare_response( changing data = ls_response ).
    if response-code = cl_rest_status_code=>gc_success_ok and line_exists( ls_response-obj_response[ code = '200' ] ).
      response-content = /ui2/cl_json=>serialize(
        data = ls_response-obj_response
        compress = abap_true
        pretty_name = /ui2/cl_json=>pretty_mode-camel_case
      ).
    elseif response-code = cl_rest_status_code=>gc_success_ok and not line_exists( ls_response-obj_response[ code = '200' ] ).
      response-code = cl_rest_status_code=>gc_server_error_internal.
      response-content = /ui2/cl_json=>serialize(
        data = ls_response-obj_response
        compress = abap_true
        pretty_name = /ui2/cl_json=>pretty_mode-camel_case
      ).
    else.
      response-content = /ui2/cl_json=>serialize(
        data = ls_response
        compress = abap_true
        pretty_name = /ui2/cl_json=>pretty_mode-camel_case
      ).
    endif.

  endmethod.