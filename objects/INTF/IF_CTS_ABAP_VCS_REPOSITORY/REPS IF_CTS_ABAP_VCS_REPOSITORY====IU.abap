interface IF_CTS_ABAP_VCS_REPOSITORY
  public .


  types TY_REPOSITORY_ID type SCTS_ABAP_VCS_REPOSITORY_ID .
  types TY_REPOSITORY_NAME type SCTS_ABAP_VCS_REPOSITORY_NAME .
  types TY_REPOSITORY_TYPE type SCTS_ABAP_VCS_REPOSITORY_TYPE .
  types TY_REPOSITORY_VSID type SCTS_TY_SYSTEM_NAME .
  types TY_REPOSITORY_PUBLIC type BOOLEAN .
  types TY_REPOSITORY_CREATED_BY type UNAME .
  types TY_REPOSITORY_CREATED_DATE type DATE_ .
  types TY_COMMIT_ID type SCTS_ABAP_VCS_COMMIT_HASH .
  types TY_REPOSITORY_VERSION type STRING .
  types:
    begin of ty_repository,
      id         type ty_repository_id,
      repository type ref to if_cts_abap_vcs_repository,
    end of ty_repository .
  types:
    tt_repository type standard table of ty_repository with default key .
  types:
    tt_repository_database type standard table of scts_avcs_repo with default key .
  types:
    tt_repository_config type standard table of scts_avcs_repocf with default key .
  types:
    begin of ty_repository_json,
      rid            type scts_abap_vcs_repository_id,
      name           type scts_abap_vcs_repository_name,
      role           type scts_abap_vcs_repository_role,
      type           type scts_abap_vcs_repository_type,
      vsid           type scts_avcs_repo-vsid,
      private_flag   type scts_avcs_repo-private_flag,
      status         type scts_avcs_repo-status,
      branch         type scts_avcs_repo-branch,
      url            type scts_avcs_repo-url,
      created_by     type scts_avcs_repo-created_by,
      created_date   type scts_avcs_repo-created_date,
      config         type if_cts_abap_vcs_config_handler=>tt_config,
      version        type ty_repository_version,
      objects        type i,
      current_commit type scts_abap_vcs_commit_hash,
      connection     type string,
    end of ty_repository_json .
  types:
    tt_repository_json type standard table of ty_repository_json with default key .
  types:
    begin of ty_repository_manifest,
      rid          type scts_abap_vcs_repository_id,
      role         type scts_abap_vcs_repository_role,
      type         type scts_abap_vcs_repository_type,
      name         type scts_abap_vcs_repository_name,
      created_by   type scts_avcs_repo-created_by,
      created_date type scts_avcs_repo-created_date,
      version      type ty_repository_version,
      commit       type ty_commit_id,
    end of ty_repository_manifest .
  types TY_REPOSITORY_ACTION type STRING .
  types:
    begin of ty_object,
      pgmid       type e071-pgmid,
      object      type e071-obj_name,
      type        type e071-object,
      e071k       type if_cts_abap_vcs_client_handler=>tt_e071k,
      description type ko100-text,
    end of ty_object .
  types:
    tt_objects type standard table of ty_object with default key .
  types:
    begin of ty_files,
      name type scts_abap_vcs_file_name,
      path type scts_abap_vcs_file_path,
      type type string,
    end of ty_files .
  types:
    tt_files type standard table of ty_files with default key .

  constants CO_REPOSITORY_STATUS_CREATED type SCTS_AVCS_REPO-STATUS value 'CREATED' ##NO_TEXT.
  constants CO_REPOSITORY_STATUS_READY type SCTS_AVCS_REPO-STATUS value 'READY' ##NO_TEXT.
  constants CO_REPOSITORY_STATUS_ERROR type SCTS_AVCS_REPO-STATUS value 'ERROR' ##NO_TEXT.
  constants CO_REPOSITORY_STATUS_MERGE type SCTS_AVCS_REPO-STATUS value 'MERGE' ##NO_TEXT.
  constants CO_REPOSITORY_STATUS_CHECKOUT type SCTS_AVCS_REPO-STATUS value 'CHECKOUT' ##NO_TEXT.
  constants CO_REPOSITORY_ACTION_CREATE type TY_REPOSITORY_ACTION value 'GET_SOURCE_FROM_REMOTE' ##NO_TEXT.
  constants CO_REPOSITORY_ACTION_CLONE type TY_REPOSITORY_ACTION value 'CLONE' ##NO_TEXT.
  constants CO_REPOSITORY_ACTION_DEPLOY type TY_REPOSITORY_ACTION value 'DEPLOY' ##NO_TEXT.
  constants CO_REPOSITORY_ACTION_PULL type TY_REPOSITORY_ACTION value 'PULL_BY_COMMIT' ##NO_TEXT.
  constants CO_REPOSITORY_ACTION_COMMIT type TY_REPOSITORY_ACTION value 'COMMIT' ##NO_TEXT.
  constants CO_REPOSITORY_ACTION_PUSH type TY_REPOSITORY_ACTION value 'PUSH' ##NO_TEXT.
  constants CO_REPOSITORY_ACTION_COMMITSRC type TY_REPOSITORY_ACTION value 'COMMIT_SOURCE' ##NO_TEXT.
  constants CO_REPOSITORY_ACTION_DELETE type TY_REPOSITORY_ACTION value 'DELETE' ##NO_TEXT.
  constants CO_REPOSITORY_ACTION_GETCOMMIT type TY_REPOSITORY_ACTION value 'GET_COMMITS' ##NO_TEXT.
  constants CO_REPOSITORY_ACTION_C_COMMIT type TY_REPOSITORY_ACTION value 'GET_CURRENT_COMMIT' ##NO_TEXT.
  constants CO_REPOSITORY_ACTION_COMP_COMM type TY_REPOSITORY_ACTION value 'COMPARE_COMMIT' ##NO_TEXT.
  constants CO_REPOSITORY_ACTION_SSL_VERI type TY_REPOSITORY_ACTION value 'SSL_VERIFICATION' ##NO_TEXT.
  constants CO_REPOSITORY_ACTION_SW_BRANCH type TY_REPOSITORY_ACTION value 'SWITCH_BRANCH' ##NO_TEXT.
  constants CO_REPOSITORY_ACTION_COMPARE type TY_REPOSITORY_ACTION value 'COMPARE_COMMITS' ##NO_TEXT.
  constants CO_REPOSITORY_ACTION_VALIDATE type TY_REPOSITORY_ACTION value 'VALIDATE' ##NO_TEXT.
  constants CO_REPOSITORY_ACTION_CREATE_WS type TY_REPOSITORY_ACTION value 'CREATE_WORKSPACE' ##NO_TEXT.
  constants CO_REPOSITORY_ACTION_GETSTATUS type TY_REPOSITORY_ACTION value 'GET_REPOSITORY_STATUS' ##NO_TEXT.
  constants CO_REPOSITORY_ACTION_RESET type TY_REPOSITORY_ACTION value 'RESET_REPOSITORY' ##NO_TEXT.
  constants CO_REPOSITORY_ACTION_ADD_FILES type TY_REPOSITORY_ACTION value 'ADD_FILES' ##NO_TEXT.
  constants CO_REPOSITORY_ACTION_STATUS type TY_REPOSITORY_ACTION value 'STATUS' ##NO_TEXT.
  constants CO_REPOSITORY_ACTION_GET_FILES type TY_REPOSITORY_ACTION value 'GET_REPOSITORY_FILES' ##NO_TEXT.
  constants CO_REPOSITORY_ACTION_GET_OBJS type TY_REPOSITORY_ACTION value 'GET_OBJECTS' ##NO_TEXT.
  constants CO_REPOSITORY_ACTION_ZIP_REPO type TY_REPOSITORY_ACTION value 'ZIP_REPOSITORY' ##NO_TEXT.
  constants CO_REPODIR_SSH type STRING value 'ssh' ##NO_TEXT.
  constants CO_REPODIR_SSL type STRING value 'ssl' ##NO_TEXT.
  constants CO_REPODIR_VCS type STRING value 'data' ##NO_TEXT.
  constants CO_REPODIR_LOG type STRING value 'log' ##NO_TEXT.
  constants CO_REPODIR_DIFF type STRING value 'diff' ##NO_TEXT.
  constants CO_REPODIR_TMP type STRING value 'tmp' ##NO_TEXT.
  constants CO_REPODIR_TMP_OBJECTS type STRING value 'tmp_objects' ##NO_TEXT.
  constants CO_REPODIR_RESPONSE type STRING value 'response' ##NO_TEXT.
  constants CO_REPODIR_TARGET type STRING value 'targetdir' ##NO_TEXT.
  constants CO_REPODIR_NAMETABS type STRING value 'nametabs' ##NO_TEXT.
  constants CO_REPODIR_OBJECTS type STRING value 'objects' ##NO_TEXT.
  constants CO_REPODIR_HANA type STRING value 'hana' ##NO_TEXT.
  constants CO_REPODIR_DIFF_FILE_LOG type STRING value '{diff-file=' ##NO_TEXT.
  constants CO_REPODIR_DIFF_FILE type STRING value 'diff_' ##NO_TEXT.
  constants CO_REPODIR_SSH_FILE type EPS2FILNAM value 'id_rsa' ##NO_TEXT.
  constants CO_REPO_ROLE_SRC type SCTS_ABAP_VCS_REPOSITORY_ROLE value 'SOURCE' ##NO_TEXT.
  constants CO_REPO_ROLE_TAR type SCTS_ABAP_VCS_REPOSITORY_ROLE value 'TARGET' ##NO_TEXT.
  constants CO_REPO_VERSION type TY_REPOSITORY_VERSION value '1.0.0' ##NO_TEXT.
  constants CO_REPO_DEFAULT_LICENSE type STRING value 'MIT' ##NO_TEXT.
  constants CO_REPO_MANIFEST type EPS2FILNAM value 'manifest.json' ##NO_TEXT.
  constants CO_REPO_PROPERTIES type EPS2FILNAM value '.gcts.properties.json' ##NO_TEXT.
  constants CO_REPO_LAYOUT_FORMAT_XML type STRING value 'xml' ##NO_TEXT.
  constants CO_REPO_LAYOUT_FORMAT_JSON type STRING value 'json' ##NO_TEXT.
  constants CO_REPO_LAYOUT_FORMATVERSION type I value 2 ##NO_TEXT.
  constants CO_REPO_LAYOUT_OBJSTORAGE type STRING value 'plain' ##NO_TEXT.
  constants CO_REPO_LAYOUT_METAINFO type STRING value '.gctsmetadata/' ##NO_TEXT.
  constants CO_REPO_LAYOUT_TABLE_CONTENT type STRING value 'true' ##NO_TEXT.
  constants CO_REPO_LAYOUT_MAX_VERSION type I value 4 ##NO_TEXT.
  constants CO_REPO_TYPE_GITLAB type STRING value 'GITLAB' ##NO_TEXT.
  constants CO_REPO_TYPE_GITHUB type STRING value 'GITHUB' ##NO_TEXT.
  constants CO_REPO_TYPE_GIT type STRING value 'GIT' ##NO_TEXT.
  constants CO_REPO_HISTORY_PULL type SCTS_ABAP_VCS_HISTORY_TYPE value 'PULL' ##NO_TEXT.
  constants CO_REPO_HISTORY_CLONE type SCTS_ABAP_VCS_HISTORY_TYPE value 'CLONE' ##NO_TEXT.
  constants CO_REPO_HISTORY_COMMIT type SCTS_ABAP_VCS_HISTORY_TYPE value 'COMMIT' ##NO_TEXT.
  constants CO_REPO_HISTORY_DEPLOY type SCTS_ABAP_VCS_HISTORY_TYPE value 'DEPLOY' ##NO_TEXT.

  class-methods CHECK_GITHUB
    importing
      !URL type STRING
    returning
      value(IS_GITHUB) type BOOLEAN .
  methods GET_CURRENT_COMMIT
    returning
      value(COMMIT) type SCTS_ABAP_VCS_COMMIT_HASH
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods SET_CURRENT_COMMIT
    importing
      !COMMIT type SCTS_ABAP_VCS_COMMIT_HASH
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods GET_COMMIT_HISTORY .
  methods GET_CONFIG_BY_KEY
    importing
      !KEY type SCTS_ABAP_VCS_CONFIG_KEY
    returning
      value(VALUE) type IF_CTS_ABAP_VCS_CONFIG_HANDLER=>TY_CONF_VALUE .
  methods GET_PATH
    importing
      !SUBDIR type STRING optional
    returning
      value(PATH) type STRING .
  methods SET_CONFIG_BY_KEY
    importing
      !KEY type SCTS_ABAP_VCS_CONFIG_KEY
      !VALUE type IF_CTS_ABAP_VCS_CONFIG_HANDLER=>TY_CONF_VALUE
      !TMP type BOOLEAN optional
      !PROTECTED type BOOLEAN optional
      !SCOPE type SCTS_ABAP_VCS_CONFIG_SCOPE optional
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
  methods SET_CONFIG
    importing
      !CONFIG type IF_CTS_ABAP_VCS_CONFIG_HANDLER=>TT_CONFIG
      !TMP type BOOLEAN optional
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods GET_CONFIG
    returning
      value(CONFIG) type IF_CTS_ABAP_VCS_CONFIG_HANDLER=>TT_CONFIG .
  methods GET_ID
    returning
      value(ID) type SCTS_ABAP_VCS_REPOSITORY_ID .
  methods SET_NAME
    importing
      !NAME type SCTS_AVCS_REPO-NAME
      !TMP type BOOLEAN optional
    returning
      value(REPOSITORY) type ref to IF_CTS_ABAP_VCS_REPOSITORY .
  methods GET_NAME
    returning
      value(NAME) type SCTS_AVCS_REPO-NAME .
  methods SET_TYPE
    importing
      !TYPE type SCTS_AVCS_REPO-TYPE
      !TMP type BOOLEAN optional
    returning
      value(REPOSITORY) type ref to IF_CTS_ABAP_VCS_REPOSITORY .
  methods GET_TYPE
    returning
      value(TYPE) type SCTS_AVCS_REPO-TYPE .
  methods SET_VSID
    importing
      !VSID type SCTS_AVCS_REPO-VSID
      !TMP type BOOLEAN optional
    returning
      value(REPOSITORY) type ref to IF_CTS_ABAP_VCS_REPOSITORY .
  methods GET_VSID
    returning
      value(VSID) type SCTS_AVCS_REPO-VSID .
  methods SET_PRIVATE_FLAG
    importing
      !PRIVATE type SCTS_AVCS_REPO-PRIVATE_FLAG
      !TMP type BOOLEAN optional
    returning
      value(REPOSITORY) type ref to IF_CTS_ABAP_VCS_REPOSITORY .
  methods GET_PRIVATE_FLAG
    returning
      value(PRIVATE_FLAG) type SCTS_AVCS_REPO-PRIVATE_FLAG .
  methods SET_ROLE
    importing
      !ROLE type SCTS_AVCS_REPO-ROLE
      !TMP type BOOLEAN optional
    returning
      value(REPOSITORY) type ref to IF_CTS_ABAP_VCS_REPOSITORY .
  methods GET_ROLE
    returning
      value(ROLE) type SCTS_AVCS_REPO-ROLE .
  methods SET_BRANCH
    importing
      !BRANCH type SCTS_AVCS_REPO-BRANCH
      !TMP type BOOLEAN optional
    returning
      value(REPOSITORY) type ref to IF_CTS_ABAP_VCS_REPOSITORY .
  methods GET_BRANCH
    returning
      value(BRANCH) type SCTS_AVCS_REPO-BRANCH .
  methods SET_URL
    importing
      !URL type SCTS_AVCS_REPO-URL
      !TMP type BOOLEAN optional
    returning
      value(REPOSITORY) type ref to IF_CTS_ABAP_VCS_REPOSITORY .
  methods GET_URL
    returning
      value(URL) type SCTS_AVCS_REPO-URL .
  methods SET_STATUS
    importing
      !STATUS type SCTS_AVCS_REPO-STATUS
      !TMP type BOOLEAN optional
    returning
      value(REPOSITORY) type ref to IF_CTS_ABAP_VCS_REPOSITORY .
  methods GET_STATUS
    returning
      value(STATUS) type SCTS_AVCS_REPO-URL .
  methods GET_HASH
    returning
      value(URL) type SCTS_AVCS_REPO-RID_HASH .
  methods GET_SYSTEM
    returning
      value(SYSTEM) type ref to IF_CTS_ABAP_VCS_SYSTEM .
  methods GET_COMMIT_OBJECT
    importing
      !HASH type SCTS_ABAP_VCS_COMMIT_HASH
    returning
      value(COMMIT) type ref to IF_CTS_ABAP_VCS_COMMIT .
  methods GET_CREATE_USER
    returning
      value(USER) type SCTS_AVCS_REPO-CREATED_BY .
  methods GET_CREATE_DATE
    returning
      value(DATE) type SCTS_AVCS_REPO-CREATED_DATE .
  methods GET_HISTORY
    returning
      value(R_HISTORY) type ref to CL_CTS_ABAP_VCS_HISTORY .
  methods TO_JSON_OBJECT
    importing
      !FULL_DATA type BOOLEAN optional
    returning
      value(OBJECT) type TY_REPOSITORY_JSON .
  methods GET_SOURCE_FROM_REMOTE
    importing
      !SYNC type BOOLEAN optional
    returning
      value(RESULT) type SCTS_AVCS_REPHIS
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods COMMIT_SOURCE_TO_REMOTE
    importing
      !COMMIT type ref to IF_CTS_ABAP_VCS_COMMIT
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods UPDATE
    returning
      value(RESULT) type SCTS_AVCS_REPHIS
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods PULL_BY_COMMIT
    importing
      !COMMIT_ID type SCTS_ABAP_VCS_COMMIT_HASH optional
      !SYNC type BOOLEAN optional
    returning
      value(RESULT) type SCTS_AVCS_REPHIS
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods GET_COMMITS
    importing
      !COMMIT type SCTS_ABAP_VCS_COMMIT_HASH optional
      !MESSAGE type STRING optional
      !AUTHOR type STRING optional
      !AUTHOR_MAIL type STRING optional
      !FROM_DATE type STRING optional
      !TO_DATE type STRING optional
      !BRANCH type STRING optional
      !TAG_NAME type STRING optional
    returning
      value(COMMITS) type IF_CTS_ABAP_VCS_COMMIT=>TT_COMMIT
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods COMPARE_COMMITS
    importing
      !FROM_COMMIT type SCTS_ABAP_VCS_COMMIT_HASH
      !TO_COMMIT type SCTS_ABAP_VCS_COMMIT_HASH
    returning
      value(OBJECTS) type IF_CTS_ABAP_VCS_COMMIT=>TT_COMMIT_OBJECT
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods GET_TECHNICAL_STATUS
    returning
      value(CONTENT) type CL_CTS_ABAP_VCS_OS_RESPONSE=>TY_RESPONSE_REPOSITORY_STATUS
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods DELETE
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods MODIFY
    importing
      !DATA type TY_REPOSITORY_JSON
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods PUSH
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods COMMIT
    importing
      !COMMIT type ref to IF_CTS_ABAP_VCS_COMMIT
      !ALL type BOOLEAN optional
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods GET_VERSION
    returning
      value(VERSION) type TY_REPOSITORY_VERSION .
  methods GET_MANIFEST
    returning
      value(MANIFEST) type TY_REPOSITORY_MANIFEST .
  methods VALIDATE
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods SWITCH_BRANCH
    importing
      !BRANCH type CL_CTS_ABAP_VCS_BRANCH=>TY_NAME
      !SYNC type BOOLEAN optional
    returning
      value(RESULT) type SCTS_AVCS_REPHIS
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods GET_BRANCHES
    returning
      value(BRANCHES) type CL_CTS_ABAP_VCS_BRANCH=>TT_BRANCH
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods GET_OBJECTS
    returning
      value(OBJECTS) type TT_OBJECTS
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods GET_CLIENT_HANDLER
    returning
      value(HANDLER) type ref to IF_CTS_ABAP_VCS_CLIENT_HANDLER .
  methods GET_PROPERTY
    importing
      !REFRESH type BOOLEAN optional
    returning
      value(PROPERTY) type ref to CL_CTS_ABAP_VCS_REPO_PROPERTY .
  methods CREATE_WORKSPACE
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods CHECK_WORK_STATUS
    returning
      value(WORKING) type BOOLEAN .
  methods GET_CONFLICTING_FILES
    returning
      value(RT_FILES) type TT_FILES
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods GET_ANONYMIZATION_VALUES
    returning
      value(RT_ANONYMIZATION_VALUES) type IF_CTS_ABAP_VCS_FILE_HANDLER=>TT_ANONYMIZATION .
  methods GET_API_ENDPOINT
    returning
      value(ENDPOINT) type CL_CTS_ABAP_VCS_USER=>TY_CREDENTIALS-ENDPOINT .
  methods GET_REMOTE_NAMESPACE
    returning
      value(NAMESPACE) type STRING
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods GET_REMOTE_NAME
    returning
      value(NAME) type STRING
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods GET_REGISTRY
    returning
      value(REGISTRY) type ref to CL_CTS_ABAP_VCS_REGISTRY .
  methods RESET
    returning
      value(STATUS) type CL_CTS_ABAP_VCS_OS_RESPONSE=>TY_RESPONSE_REPOSITORY_STATUS
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods ADD_FILES
    importing
      !FILES type CL_CTS_ABAP_VCS_OS_RESPONSE=>TT_JAVA_FILES
    returning
      value(STATUS) type CL_CTS_ABAP_VCS_OS_RESPONSE=>TY_RESPONSE_REPOSITORY_STATUS
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods DEPLOY
    importing
      !SCOPE type SCTS_ABAP_VCS_REPO_DEPLOYSCOPE optional
      !COMMIT type SCTS_ABAP_VCS_COMMIT_HASH optional
      !OBJECTS type IF_CTS_ABAP_VCS_TRANSPORT_REQ=>TT_OBJECTS optional
    returning
      value(RESULT) type SCTS_AVCS_REPHIS
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods ZIP
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
endinterface.