  method update_branch.

    data: ls_request type cl_cts_abap_vcs_registry_fac=>ty_update_branch_request.
    data: ls_response type cl_cts_abap_vcs_registry_fac=>ty_update_branch_response.

    /ui2/cl_json=>deserialize(
       exporting
         json = update_body
         pretty_name = 'X'
       changing
         data = ls_request-update_branch_info
     ).

    ls_request-repository = repository.
    ls_request-name = cl_http_utility=>unescape_url( name ).

    ls_response = cl_cts_abap_vcs_registry_fac=>update_branch( request = ls_request ).

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