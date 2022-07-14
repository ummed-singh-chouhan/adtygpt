  method register_object.

    data: ls_request type cl_cts_abap_vcs_reg_ser_fac=>ty_register_object_request.
    data: ls_response type cl_cts_abap_vcs_reg_ser_fac=>ty_register_object_response.

    /ui2/cl_json=>deserialize(
       exporting
         json = request
         pretty_name = 'X'
       changing
         data = ls_request
     ).
    data(ls_branch) = cl_http_client=>if_http_client~unescape_url( branch ).
    ls_response = cl_cts_abap_vcs_reg_ser_fac=>register_object( repository_id = conv #( repository_id ) branch = conv #( ls_branch ) object = ls_request ).

    response-code = prepare_response( changing data = ls_response ).
    if response-code = 200.
      response-content = /ui2/cl_json=>serialize(
      data = ls_response-object_response
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