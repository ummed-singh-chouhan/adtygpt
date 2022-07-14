  method save_file_content.

    data: ls_request  type cl_cts_abap_vcs_file_facade=>ty_save_file_content_request,
          ls_response type cl_cts_abap_vcs_file_facade=>ty_save_file_content_response.

*   Get the file content and the encoding schema from the request body
    /ui2/cl_json=>deserialize(
     exporting
       json        = request_body
       pretty_name = /ui2/cl_json=>pretty_mode-camel_case
     changing
       data        = ls_request ).

    ls_request-repository    = repository.
    ls_request-object_name   = object_name.
    ls_request-object_type   = object_type.
    ls_request-prefix        = prefix.
*   Unescape the filename ...
    ls_request-file_name     = cl_http_client=>if_http_client~unescape_url( file_name ).

    " Replace ~ to url encoded string %7E because the most browser will convert it to the proper character but this will lead to wrong file name
    ls_request-file_name = replace( val = ls_request-file_name sub = '~' with = '%7E' ).
    replace all occurrences of regex '\/' in ls_request-file_name with '%2F'.

    ls_response = cl_cts_abap_vcs_file_facade=>save_file_content( ls_request ).

    response-code = prepare_response( changing data = ls_response ).
    response-content = /ui2/cl_json=>serialize(
      data        = ls_response
      compress    = abap_true
      pretty_name = /ui2/cl_json=>pretty_mode-camel_case ).

  endmethod.