  method if_cts_abap_vcs_repo_data_hdlr~prepare_tms_config.
    data exc type ref to cx_root.
    data tms_exc type ref to cx_cts_tms_configure_exception .
    data basic_fac type ref to if_cts_tms_basic_configuration.
    data route_fac type ref to if_cts_tms_transport_routes.

    me->logger->log_start( action = 'PREPARE_TMS_CONFIG' ).

    basic_fac = cl_cts_tms_basic_configuration=>create( abap_false ).
    data(tp_param) = cl_cts_tms_tp_parameter_config=>create( abap_false ).
    try.
        data(domain) = basic_fac->get_domain_controller( ).
      catch cx_cts_tms_configure_exception into data(exc2).

    endtry.
    try.
        data(vcs_system) = basic_fac->get_system_details( repository->get_vsid( ) ).
      catch cx_root into exc.
    endtry.

    if domain-name = sy-sysid.
      if vcs_system is initial.

*      if sy-sysid = 'AT5' or sy-sysid = 'AT6' or sy-sysid = 'W09'.

*        if me->role = if_cts_abap_vcs_repository=>co_repo_role_src.

        data: lv_layer type devlayer.
        lv_layer = repository->get_config_by_key( if_cts_abap_vcs_config_handler=>co_conf_repo_transport_layer ).
        if lv_layer is initial.
          lv_layer = |Z{ repository->get_vsid( ) }|.
          try.
              repository->set_config_by_key( key = if_cts_abap_vcs_config_handler=>co_conf_repo_transport_layer value = conv #( lv_layer ) ).
            catch cx_cts_abap_vcs_exception.
          endtry.
        endif.
        try.
            route_fac = cl_cts_tms_configure_factory=>create( abap_false )->transport_route_configurator( ).
            basic_fac->add_nonabap_client( system_name = repository->get_vsid( ) system_text = 'gCTS generated' ) ##NO_TEXT.
          catch cx_root into exc.
        endtry.
        try.
            route_fac->lock( ).
          catch cx_root into exc.
        endtry.

        try.
            route_fac->add_transport_layer( name = lv_layer description = 'gCTS generated' ) ##NO_TEXT.
          catch cx_root into exc.
        endtry.

        try.
            route_fac->add_consolidation( fromsystem = conv #( sy-sysid ) target = repository->get_vsid( ) transport_layer = lv_layer ).
          catch cx_root into exc.
        endtry.
        try.
            route_fac->activate( ).
          catch cx_root into exc.
        endtry.
        try.
            tp_param->if_cts_tms_tpprofile_parameter~set_local_parameter(
              sysname = repository->get_vsid( )
              name = if_cts_abap_vcs_system=>co_tms_jarpath
              value = jar_path
            ).
            tp_param->if_cts_tms_tpprofile_parameter~set_local_parameter(
              sysname = repository->get_vsid( )
              name = if_cts_abap_vcs_system=>co_tms_javapath
              value = java_path
            ).
*              tp_param->if_cts_tms_tpprofile_parameter~set_local_parameter(
*                sysname = me->if_cts_abap_vcs_repository~get_vsid( )
*                name = if_cts_abap_vcs_system=>co_tms_repopath
*                value = me->system->get_config_by_key( key = if_cts_abap_vcs_system=>co_sysconf_vcs_path )
*              ).

*            tp_param->if_cts_tms_tpprofile_parameter~set_local_parameter(
*              sysname = me->if_cts_abap_vcs_repository~get_vsid( )
*              name = if_cts_abap_vcs_system=>co_tms_vcs_wbo
*              value = sy-mandt
*            ).


            tp_param->if_cts_tms_tpprofile_parameter~set_local_parameter(
              sysname = repository->get_vsid( )
              name = if_cts_abap_vcs_system=>co_tms_vcs_system
              value = if_cts_abap_vcs_system=>co_tms_vcs_system_value
            ).

            tp_param->if_cts_tms_tpprofile_parameter~set_local_parameter(
              sysname = repository->get_vsid( )
              name = if_cts_abap_vcs_system=>co_tms_trans_sync
              value = if_cts_abap_vcs_system=>co_tms_trans_sync_value
            ).


          catch cx_root into exc.
        endtry.
        try.
            route_fac->unlock( ).
            basic_fac->distribute_config( ).
          catch cx_root into exc.
            cx_cts_abap_vcs_exception=>get_message_recursive( exc ).
        endtry.
*        endif.
*      endif.

      else.
        if vcs_system-is_controller = abap_true.
          try.
              tp_param->if_cts_tms_tpprofile_parameter~set_local_parameter(
                sysname = repository->get_vsid( )
                name = if_cts_abap_vcs_system=>co_tms_jarpath
                value = jar_path
              ).
              tp_param->if_cts_tms_tpprofile_parameter~set_local_parameter(
                sysname = repository->get_vsid( )
                name = if_cts_abap_vcs_system=>co_tms_javapath
                value = java_path
              ).
            catch cx_cts_tms_configure_exception  into tms_exc.
              me->logger->log_error( action = 'PREPARE_TMS_CONFIG' info = tms_exc->get_longtext( ) ).
          endtry.
        endif.
      endif.
    endif.

    cl_spfl_profile_parameter=>get_value( exporting name  = if_cts_abap_vcs_system=>co_profile_parameter_dir_trans
                                          importing value = data(dir_trans)
                                          receiving rc    = data(rc) ).
    if rc <> 0.
       me->logger->log_info( action = 'PREPARE_TMS_CONFIG' info = |Getting the value of the profile parameter "{ if_cts_abap_vcs_system=>co_profile_parameter_dir_trans }" failed| ) ##NO_TEXT.
    elseif dir_trans is initial.
       me->logger->log_info( action = 'PREPARE_TMS_CONFIG' info = |The value of the profile parameter "{ if_cts_abap_vcs_system=>co_profile_parameter_dir_trans }" is initial| ) ##NO_TEXT.
    else.
      cl_cts_abap_vcs_tp_helper=>get_instance( repository = repository )->set_trans_dir( dir_trans ).
    endif.

    me->logger->log_end( action = 'PREPARE_TMS_CONFIG' ).
  endmethod.