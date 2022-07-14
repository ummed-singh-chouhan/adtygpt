  method if_cts_abap_vcs_repo_data_hdlr~get_customizing_objects.

    if not branch is initial and not commit is initial.
      select * from scts_avcs_indexk
      into table customizing_objects
      where rid = repository
      and commit_hash = commit
      and branch = branch.
    elseif not commit is initial.
      select * from scts_avcs_indexk
      into table customizing_objects
      where rid = repository
      and commit_hash = commit.
    elseif not branch is initial .
      select * from scts_avcs_indexk
      into table customizing_objects
      where rid = repository
      and branch = branch.
    else.
      select * from scts_avcs_indexk
      into table customizing_objects
      where rid = repository.
    endif.

  endmethod.