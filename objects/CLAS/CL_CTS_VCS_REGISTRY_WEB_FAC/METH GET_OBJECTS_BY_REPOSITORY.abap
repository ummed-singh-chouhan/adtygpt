  method get_objects_by_repository.

    data: ls_request type cl_cts_abap_vcs_registry_fac=>ty_get_objects_by_rep_request.
    data: ls_response type cl_cts_abap_vcs_registry_fac=>ty_get_objects_by_rep_response.

    ls_request-repository = repository.
    ls_request-branch = cl_http_utility=>unescape_url( branch ).

    ls_response = cl_cts_abap_vcs_registry_fac=>get_objects_by_repository( ls_request ).

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