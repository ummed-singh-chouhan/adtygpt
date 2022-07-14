interface IF_CTS_ABAP_VCS_LOGGER
  public .


  types:
    begin of ty_protocol,
           type     type string,
           protocol type if_cts_abap_vcs_file_handler=>tt_content,
         end of ty_protocol .
  types:
    tt_protocol type standard table of ty_protocol with default key .
  types:
    begin of ty_log,
           time     type timestamp,
           user     type uname,
           section  type string,
           action   type string,
           severity type string,
           message  type string,
           protocol type tt_protocol,
           code     type string,
         end of ty_log .
  types:
    tt_log type standard table of ty_log with default key .
  types:
    tt_btcxpm type standard table of btcxpm with default key .
  types:
    tt_stdout type standard table of tpstdout with default key .
  types:
    tt_process type standard table of scts_avcs_log with default key .
  types:
    tt_process_entry type standard table of scts_avcs_logent with default key .
  types:
    begin of ty_log_line_message,
             message_v1 type SYMSG-MSGV1,
             message_v2 type SYMSG-MSGV2,
             message_v3 type SYMSG-MSGV3,
             message_v4 type SYMSG-MSGV4,
         end of ty_log_line_message .

  constants CO_MSG_CLASS type STRING value 'SCTS_ABAP_VCS_MSG' ##NO_TEXT.
  constants CO_SEVERITY_DEBUG type STRING value 'DEBUG' ##NO_TEXT.
  constants CO_SEVERITY_INFO type STRING value 'INFO' ##NO_TEXT.
  constants CO_SEVERITY_WARNING type STRING value 'WARNING' ##NO_TEXT.
  constants CO_SEVERITY_ERROR type STRING value 'ERROR' ##NO_TEXT.
  constants CO_MSG_NO_START type SYMSG-MSGNO value 600 ##NO_TEXT.
  constants CO_MSG_NO_ERROR type SYMSG-MSGNO value 602 ##NO_TEXT.
  constants CO_MSG_NO_INFO type SYMSG-MSGNO value 603 ##NO_TEXT.
  constants CO_MSG_NO_END type SYMSG-MSGNO value 601 ##NO_TEXT.
  constants CO_LOG_SECTION_CLIENT_TP type TY_LOG-SECTION value 'CLIENT_TP' ##NO_TEXT.
  constants CO_LOG_SECTION_CLIENT_CMD type TY_LOG-SECTION value 'CLIENT_CMD' ##NO_TEXT.
  constants CO_LOG_SECTION_CLIENT_GIT type TY_LOG-SECTION value 'CLIENT_GIT' ##NO_TEXT.
  constants CO_LOG_SECTION_CLIENT_HTTP type TY_LOG-SECTION value 'CLIENT_HTTP' ##NO_TEXT.
  constants CO_LOG_SECTION_REPOSITORY type TY_LOG-SECTION value 'REPOSITORY' ##NO_TEXT.
  constants CO_LOG_SECTION_REPO_PROPERTY type TY_LOG-SECTION value 'REPOSITORY_PROPERTY' ##NO_TEXT.
  constants CO_LOG_SECTION_BRANCH type TY_LOG-SECTION value 'BRANCH' ##NO_TEXT.
  constants CO_LOG_SECTION_REPOSITORY_FAC type TY_LOG-SECTION value 'REPOSITORY_FACTORY' ##NO_TEXT.
  constants CO_LOG_SECTION_SYSTEM type TY_LOG-SECTION value 'SYSTEM' ##NO_TEXT.
  constants CO_LOG_SECTION_HANDLER_NAMETAB type TY_LOG-SECTION value 'HANDLER_NAMETAB' ##NO_TEXT.
  constants CO_LOG_SECTION_HANDLER_META type TY_LOG-SECTION value 'HANDLER_META' ##NO_TEXT.
  constants CO_LOG_SECTION_HANDLER_HANA type TY_LOG-SECTION value 'HANDLER_HANA' ##NO_TEXT.
  constants CO_LOG_SECTION_HANDLER_OBJECTS type TY_LOG-SECTION value 'HANDLER_OBJECTS' ##NO_TEXT.
  constants CO_LOG_SECTION_HANDLER_GITHUB type TY_LOG-SECTION value 'HANDLER_GITHUB' ##NO_TEXT.
  constants CO_LOG_SECTION_HANDLER_TMP type TY_LOG-SECTION value 'HANDLER_TMP' ##NO_TEXT.
  constants CO_LOG_SECTION_HANDLER_FILE type TY_LOG-SECTION value 'HANDLER_FILE' ##NO_TEXT.
  constants CO_LOG_SECTION_HANDLER_DB type TY_LOG-SECTION value 'HANDLER_DB' ##NO_TEXT.
  constants CO_LOG_SECTION_HANDLER_REPO_DB type TY_LOG-SECTION value 'HANDLER_REPO_DB' ##NO_TEXT.
  constants CO_LOG_SECTION_HANDLER_SYS_DB type TY_LOG-SECTION value 'HANDLER_SYSTEM_DB' ##NO_TEXT.
  constants CO_LOG_SECTION_HANDLER_TP type TY_LOG-SECTION value 'HANDLER_TP' ##NO_TEXT.
  constants CO_LOG_SECTION_REPO_OBJECT type TY_LOG-SECTION value 'REPOSITORY_OBJECT' ##NO_TEXT.
  constants CO_LOG_SECTION_HANDLER_CONFIG type TY_LOG-SECTION value 'HANDLER_CONFIG' ##NO_TEXT.
  constants CO_LOG_SECTION_ORGANIZER type TY_LOG-SECTION value 'ORGANIZER_FACADE' ##NO_TEXT.
  constants CO_LOG_SECTION_REGISTRY type TY_LOG-SECTION value 'REGISTRY' ##NO_TEXT.
  constants CO_LOG_SECTION_GITHUB type TY_LOG-SECTION value 'GITHUB_API' ##NO_TEXT.

  class-methods FLUSH
    importing
      !ERROR type BOOLEAN optional
    returning
      value(LOG) type TT_LOG .
  class-methods GET_LOG
    importing
      !ERROR type BOOLEAN optional
    returning
      value(LOG) type TT_LOG .
  methods LOG
    importing
      !ACTION type TY_LOG-ACTION
      !SEVERITY type TY_LOG-SEVERITY
      !NUMBER type SYMSG-MSGNO
      !VARIABLE_1 type SYMSG-MSGV1 optional
      !VARIABLE_2 type SYMSG-MSGV2 optional
      !VARIABLE_3 type SYMSG-MSGV3 optional
      !VARIABLE_4 type SYMSG-MSGV4 optional
      !LOG_LINE_MESSAGE type TY_LOG_LINE_MESSAGE optional
      !INFO type STRING optional
      !PROTOCOLS type TT_PROTOCOL optional
      !TP_RETURN type IF_CTS_ABAP_VCS_TP_HELPER=>TY_TP_RESULT optional
      !RESPONSE type ref to CL_CTS_ABAP_VCS_OS_RESPONSE optional
      !CODE type TY_LOG-CODE optional .
  methods LOG_START
    importing
      !ACTION type TY_LOG-ACTION
      !INFO type STRING optional
      !PROCESS type BOOLEAN optional .
  methods LOG_END
    importing
      !ACTION type TY_LOG-ACTION
      !INFO type STRING optional
      !PROCESS type BOOLEAN optional
      !TP_RETURN type IF_CTS_ABAP_VCS_TP_HELPER=>TY_TP_RESULT optional
      !RESPONSE type ref to CL_CTS_ABAP_VCS_OS_RESPONSE optional .
  methods LOG_INFO
    importing
      !ACTION type TY_LOG-ACTION
      !INFO type STRING optional
      !TP_RETURN type IF_CTS_ABAP_VCS_TP_HELPER=>TY_TP_RESULT optional
      !RESPONSE type ref to CL_CTS_ABAP_VCS_OS_RESPONSE optional
      !CODE type TY_LOG-CODE optional .
  methods LOG_ERROR
    importing
      !ACTION type TY_LOG-ACTION optional
      !INFO type STRING optional
      !SEVERITY type TY_LOG-SEVERITY optional
      !TP_RETURN type IF_CTS_ABAP_VCS_TP_HELPER=>TY_TP_RESULT optional
      !RESPONSE type ref to CL_CTS_ABAP_VCS_OS_RESPONSE optional
      !PROTOCOL type IF_CTS_ABAP_VCS_FILE_HANDLER=>TT_CONTENT optional
      !CODE type TY_LOG-CODE optional
      !LOG_LINE_MESSAGE type TY_LOG_LINE_MESSAGE optional .
  methods GET_CURRENT_ACTION
    returning
      value(ACTION) type TY_LOG-ACTION .
  methods CONVERT_PROTOCOL
    importing
      !PROTOCOL type TT_BTCXPM
    returning
      value(OUTPUT) type STRING .
  methods CONVERT_STDOUT
    importing
      !STDOUT type TT_STDOUT
    returning
      value(CONTENT) type IF_CTS_ABAP_VCS_FILE_HANDLER=>TT_CONTENT .
  methods CONVERT_STDOUT_TO_STRING
    importing
      !STDOUT type TT_STDOUT
    returning
      value(CONTENT) type STRING .
  methods GET_PROCESS_LIST_BY_REPOSITORY
    importing
      !REPOSITORY type SCTS_ABAP_VCS_REPOSITORY_ID
    returning
      value(LIST) type TT_PROCESS .
  methods GET_PROCESS_ENTRIES_BY_ID
    importing
      !PROCESS type SCTS_AVCS_LOG-PROCESS
    returning
      value(ENTRIES) type TT_PROCESS_ENTRY .
endinterface.