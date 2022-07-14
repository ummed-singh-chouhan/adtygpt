  method if_cts_abap_vcs_repo_data_hdlr~set_objects.

    lcl_cts_lock_handler=>lock_objects_index( rid = repository commit_hash = commit ).

    delete from scts_avcs_index
    where rid = repository
    and commit_hash = commit.

    insert scts_avcs_index from table objects accepting duplicate keys.

    if sy-subrc = 0.
      new_objects = objects.
*   Log an 'INFO' if duplicate keys occurred ...
    elseif sy-subrc = 4.
      me->logger->log_info( action = 'UPDATE_TABLE_SCTS_AVCS_INDEX' info = |Duplicate keys occurred for 'rid' { repository } and 'commit_hash' { commit } | ) ##NO_TEXT.
    endif.

    lcl_cts_lock_handler=>unlock_objects_index( rid = repository commit_hash = commit ).

  endmethod.