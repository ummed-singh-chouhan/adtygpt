  method get_branch.

    data: ls_response type cl_cts_abap_vcs_registry_fac=>ty_get_branch_response.
    data(lv_unescape_branch) = cl_http_utility=>unescape_url( name ).
    ls_response = cl_cts_abap_vcs_registry_fac=>get_branch( repository = conv #( repository ) name = lv_unescape_branch ).

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