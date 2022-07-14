  method delete_object.

    data: ls_request type cl_cts_abap_vcs_reg_ser_fac=>ty_delete_object_request.
    data: ls_response type cl_cts_abap_vcs_reg_ser_fac=>ty_delete_object_response.

    ls_request-repository_id = repository_id.
    ls_request-branch = cl_http_client=>if_http_client~unescape_url( branch ).

    /ui2/cl_json=>deserialize(
   exporting
     json = request
     pretty_name = 'X'
   changing
     data = ls_request-object
   ).

    ls_response = cl_cts_abap_vcs_reg_ser_fac=>delete_object( request = ls_request ).

    response-code = prepare_response( changing data = ls_response ).

    response-content = /ui2/cl_json=>serialize(
      data = ls_response
      compress = abap_true
      pretty_name = /ui2/cl_json=>pretty_mode-camel_case
    ).
  endmethod.