  method if_cts_abap_vcs_repo_data_hdlr~set_customizing_objects.

    lcl_cts_lock_handler=>lock_objects_index( rid = repository commit_hash = commit ).

    delete from scts_avcs_indexk
           where rid = repository
           and commit_hash = commit.

    insert scts_avcs_indexk from table customizing_objects accepting duplicate keys.

*   Log an 'INFO' if duplicate keys occurred ...
    if sy-subrc = 4.
      me->logger->log_info( action = 'UPDATE_TABLE_SCTS_AVCS_INDEXK' info = |Duplicate keys occurred for 'rid' { repository } and 'commit_hash' { commit } | ) ##NO_TEXT.
    endif.

    lcl_cts_lock_handler=>unlock_objects_index( rid = repository commit_hash = commit ).

  endmethod.