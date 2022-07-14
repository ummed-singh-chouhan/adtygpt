interface IF_CTS_ABAP_VCS_SYSTEM
  public .


  types TY_SYSTEM_ID type SCTS_AVCS_SYSTEM_ID .
  types:
    tt_system_config type standard table of scts_avcs_syscf with default key .
  types:
    tt_system type standard table of scts_avcs_system with default key .
  types:
    tt_avcs_systat type standard table of scts_avcs_systat with default key .
  types:
    begin of ty_system_status.
           include type scts_avcs_systat.
  types:   detail type tt_avcs_systat,
         end of ty_system_status .
  types:
    tt_system_status type standard table of ty_system_status with default key .
  types:
    tt_sicf type standard table of icfservloc with default key .
  types:
    begin of ty_system_json,
           sid        type scts_avcs_system-sid,
           name       type scts_avcs_system-name,
           sapsid     type scts_avcs_system-sapsid,
           workstate  type scts_avcs_system-workstate,
           config     type if_cts_abap_vcs_config_handler=>tt_config,
           status     type tt_system_status,
           client     type string,
           servername type string,
         end of ty_system_json .
  types:
    tt_system_json type standard table of ty_system_json with default key .

  constants CO_SICF_REST type STRING value 'CTS_ABAPVCS' ##NO_TEXT.
  constants CO_SICF_ODATA type STRING value 'SCTS_GCTS_SRV' ##NO_TEXT.
  constants CO_SICF_FIORI type STRING value 'BC_CTS_GIT' ##NO_TEXT.
  constants CO_TMS_JAVAPATH type STRING value 'JAVAPATH' ##NO_TEXT.
  constants CO_TMS_JARPATH type STRING value 'SAPVCSPATH' ##NO_TEXT.
  constants CO_TMS_REPOPATH type STRING value 'SAPVCSREPOPATH' ##NO_TEXT.
  constants CO_TMS_VCSPARAMS type STRING value 'DVCSPARAMS' ##NO_TEXT.
  constants CO_TMS_VCS_SYSTEM type STRING value 'NON_ABAP_SYSTEM' ##NO_TEXT.
  constants CO_TMS_TRANS_SYNC type STRING value 'SP_TRANS_SYNC' ##NO_TEXT.
  constants CO_TMS_TRANS_SYNC_VALUE type STRING value 'OFF' ##NO_TEXT.
  constants CO_TMS_VCS_SYSTEM_VALUE type STRING value 'VCS' ##NO_TEXT.
  constants CO_TMS_VCS_WBO type STRING value 'NON_ABAP_WBO_CLIENT' ##NO_TEXT.
  constants CO_SYSCONF_JAVA type SCTS_ABAP_VCS_CONFIG_KEY value 'JAVA_RUNTIME' ##NO_TEXT.
  constants CO_SYSCONF_JAR_PATH type SCTS_ABAP_VCS_CONFIG_KEY value 'A2G_RUNTIME' ##NO_TEXT.
  constants CO_SYSCONF_VCS_PATH type SCTS_ABAP_VCS_CONFIG_KEY value 'VCS_PATH' ##NO_TEXT.
  constants CO_SYSCONF_OBSERVER_COUNT type SCTS_ABAP_VCS_CONFIG_KEY value 'OBSERVER_COUNT' ##NO_TEXT.
  constants CO_SCHEDULE_JOB_REPORT type SY-REPID value 'SCTS_ABAP_VCS_IMPORT_OBSERVER' ##NO_TEXT.
  constants CO_SCHEDULE_JOB_EVENT type BTCEVENTID value 'SAP_TRIGGER_VCS_IMPORT' ##NO_TEXT.
  constants CO_PROFILE_PARAMETER_DIR_TRANS type SPFL_PARAMETER_NAME value 'DIR_TRANS' ##NO_TEXT.

  methods GET_REPOSITORY_BY_ID
    importing
      !ID type IF_CTS_ABAP_VCS_REPOSITORY=>TY_REPOSITORY_ID
      !REFRESH type BOOLEAN optional
    returning
      value(REPOSITORY) type ref to IF_CTS_ABAP_VCS_REPOSITORY
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods GET_REPOSITORY_BY_URL
    importing
      !URL type SCTS_AVCS_REPO-URL
      !REFRESH type BOOLEAN optional
    returning
      value(REPOSITORY) type ref to IF_CTS_ABAP_VCS_REPOSITORY
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods GET_REPOSITORIES
    importing
      !REFRESH type BOOLEAN optional
    returning
      value(REPOSITORIES) type IF_CTS_ABAP_VCS_REPOSITORY=>TT_REPOSITORY
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods GET_REPOSITORIES_DATA
    importing
      !REFRESH type BOOLEAN optional
    returning
      value(REPOSITORIES) type IF_CTS_ABAP_VCS_REPOSITORY=>TT_REPOSITORY_DATABASE .
  methods SET_FILE
    importing
      !TRKORR type EPS2FILNAM
      !CONTENT type XSTRING
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods GET_FILE
    importing
      !TRKORR type EPS2FILNAM
    returning
      value(CONTENT) type XSTRING
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods SET_CONFIG
    importing
      !CONFIG type IF_CTS_ABAP_VCS_CONFIG_HANDLER=>TT_CONFIG
      !TMP type BOOLEAN optional
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods GET_CONFIG
    returning
      value(CONFIG) type IF_CTS_ABAP_VCS_CONFIG_HANDLER=>TT_CONFIG .
  methods GET_CONFIG_BY_KEY
    importing
      !KEY type SCTS_ABAP_VCS_CONFIG_KEY
    returning
      value(VALUE) type IF_CTS_ABAP_VCS_CONFIG_HANDLER=>TY_CONF_VALUE .
  methods SET_CONFIG_BY_KEY
    importing
      !KEY type SCTS_ABAP_VCS_CONFIG_KEY
      !VALUE type IF_CTS_ABAP_VCS_CONFIG_HANDLER=>TY_CONF_VALUE
      !TMP type BOOLEAN optional
    returning
      value(LINE) type IF_CTS_ABAP_VCS_CONFIG_HANDLER=>TY_CONFIG
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods DELETE_CONFIG_BY_KEY
    importing
      !KEY type SCTS_ABAP_VCS_CONFIG_KEY
      !TMP type BOOLEAN optional
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods GET_NAME
    returning
      value(NAME) type SCTS_AVCS_SYSTEM-NAME .
  methods GET_WORKSTATE
    returning
      value(STATE) type SCTS_AVCS_SYSTEM-WORKSTATE .
  methods SET_WORKSTATE
    importing
      value(STATE) type SCTS_AVCS_SYSTEM-WORKSTATE .
  methods GET_SAPSID
    returning
      value(SAPSID) type SCTS_AVCS_SYSTEM-SAPSID .
  methods GET_SYS_CLIENT
    returning
      value(CLIENT) type STRING .
  methods GET_SERVER_NAME
    returning
      value(SERVER) type STRING .
  methods CREATE_REPOSITORY
    importing
      !REPOSITORY_ID type IF_CTS_ABAP_VCS_REPOSITORY=>TY_REPOSITORY_ID
      !NAME type SCTS_AVCS_REPO-NAME
      !TYPE type SCTS_AVCS_REPO-TYPE optional
      !VSID type SCTS_AVCS_REPO-VSID optional
      !ROLE type SCTS_AVCS_REPO-ROLE optional
      !PRIVATE_FLAG type SCTS_AVCS_REPO-PRIVATE_FLAG optional
      !URL type SCTS_AVCS_REPO-URL optional
      !CONFIG type IF_CTS_ABAP_VCS_CONFIG_HANDLER=>TT_CONFIG optional
    returning
      value(REPOSITORY) type ref to IF_CTS_ABAP_VCS_REPOSITORY
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods DELETE_REPOSITORY
    importing
      !REPOSITORY_ID type IF_CTS_ABAP_VCS_REPOSITORY=>TY_REPOSITORY_ID
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods ADD_REPOSITORY
    importing
      !REPOSITORY type ref to IF_CTS_ABAP_VCS_REPOSITORY
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods REMOVE_REPOSITORY
    importing
      !REPOSITORY_ID type IF_CTS_ABAP_VCS_REPOSITORY=>TY_REPOSITORY_ID
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods TRIGGER_IMPORT
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods INITIALIZE
    importing
      !TARGETSERVER type BTCSRVNAME optional
    raising
      CX_CTS_ABAP_VCS_EXCEPTION
      CX_CTS_ABAP_VCS_INVALID_CONFIG .
  methods TO_JSON_OBJECT
    returning
      value(OBJECT) type TY_SYSTEM_JSON .
  methods GET_STATUS
    importing
      !RELOAD type BOOLEAN optional
    returning
      value(STATUS) type TT_SYSTEM_STATUS .
  methods GET_REGISTRY
    returning
      value(REGISTRY) type ref to CL_CTS_ABAP_VCS_REGISTRY
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods GET_REPOSITORY_BY_OBJECT
    importing
      !OBJECT type TROBJTYPE
      !OBJ_NAME type TROBJ_NAME
      !PGMID type PGMID
    returning
      value(REPOSITORY) type ref to IF_CTS_ABAP_VCS_REPOSITORY
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods SET_DEFAULT_SYSTEM
    importing
      !FLAG type BOOLEAN
    returning
      value(SYSTEM) type ref to CL_CTS_ABAP_VCS_SYSTEM .
endinterface.