  method get_objects.

    data: ls_response type cl_cts_abap_vcs_reg_ser_fac=>ty_get_objects_response,
          ls_request  type cl_cts_abap_vcs_reg_ser_fac=>ty_get_objects_request.
    ls_request-repository_id = repository_id.
    ls_request-branch = cl_http_client=>if_http_client~unescape_url( branch ).
    ls_response = cl_cts_abap_vcs_reg_ser_fac=>get_objects( ls_request ).
    response-code = prepare_response( changing data = ls_response ).

    if response-code = 200.
      response-content = /ui2/cl_json=>serialize(
      data = ls_response-objects
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