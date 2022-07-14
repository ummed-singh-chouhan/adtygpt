  method get_branch.

    data: ls_response type cl_cts_abap_vcs_reg_ser_fac=>ty_get_branch_response.
    data(ls_branch) = cl_http_client=>if_http_client~unescape_url( branch ).
    ls_response = cl_cts_abap_vcs_reg_ser_fac=>get_branch( repository_id = conv #( repository_id ) branch = conv #( ls_branch ) ).
    response-code = prepare_response( changing data = ls_response ).

    if response-code = 200.
      response-content = /ui2/cl_json=>serialize(
      data = ls_response-branch
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