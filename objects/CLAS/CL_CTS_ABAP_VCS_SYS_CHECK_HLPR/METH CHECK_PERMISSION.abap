  method check_permission.

    call function 'TR_AUTHORITY_CHECK_ADMIN'
      exporting
*       iv_user          = SY-UNAME
        iv_adminfunction = '*'
*       iv_system        = SY-SYSID
*       iv_domain        =
      exceptions
        e_no_authority   = 1
        e_invalid_user   = 2
        others           = 3.
    if sy-subrc <> 0.
      append value #( status_key = co_permission_tp value = co_warning category = co_cat_permission ) to status.
    else.
      append value #( status_key = co_permission_tp value = co_success category = co_cat_permission ) to status.
    endif.

*    Legacy check not needed anymore
*    authority-check object 'S_LOG_COM'
*      id 'COMMAND' field '*'
*      id 'OPSYSTEM' field '*'
*      id 'HOST' field '*'.
*    if sy-subrc = 0.
*      append value #( status_key = co_permission_lcmd value = co_success category = co_cat_permission ) to status.
*    else.
*      append value #( status_key = co_permission_lcmd value = co_error category = co_cat_permission ) to status.
*    endif.

    authority-check object 'S_DATASET'
      id 'PROGRAM' field '*'
      id 'ACTVT' field '*'
      id 'FILENAME' field '*'.
    if sy-subrc = 0.
      append value #( status_key = co_permission_dataset value = co_success category = co_cat_permission ) to status.
    else.
      append value #( status_key = co_permission_dataset value = co_error category = co_cat_permission ) to status.
    endif.

    authority-check object 'S_CTS_ADMI'
      id 'CTS_ADMFCT' field '*'.
    if sy-subrc = 0.
      append value #( status_key = co_permission_cts value = co_success category = co_cat_permission ) to status.
    else.
      append value #( status_key = co_permission_cts value = co_warning category = co_cat_permission ) to status.
    endif.

*    Legacy check not needed anymore
*    authority-check object 'S_GCTS_REP'
*      id 'REPOSITORY' field '*'.
*    if sy-subrc = 0.
*      append value #( status_key = co_permission_gcts value = co_success category = co_cat_permission ) to status.
*    else.
*      append value #( status_key = co_permission_gcts value = co_warning category = co_cat_permission ) to status.
*    endif.

  endmethod.