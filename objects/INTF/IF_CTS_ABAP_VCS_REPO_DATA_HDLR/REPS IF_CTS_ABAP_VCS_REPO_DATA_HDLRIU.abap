interface IF_CTS_ABAP_VCS_REPO_DATA_HDLR
  public .


  types:
    tt_objects type standard table of scts_avcs_index with default key .
  types:
    tt_objects_customizing type standard table of scts_avcs_indexk with default key .

  methods GET_REPOSITORIES
    returning
      value(REPOSITORIES) type IF_CTS_ABAP_VCS_REPOSITORY=>TT_REPOSITORY_DATABASE .
  methods GET_CONFIG
    importing
      !REPOSITORY type SCTS_ABAP_VCS_REPOSITORY_ID
    returning
      value(CONFIG) type IF_CTS_ABAP_VCS_REPOSITORY=>TT_REPOSITORY_CONFIG .
  methods GET_HEAD
    importing
      !REPOSITORY type SCTS_ABAP_VCS_REPOSITORY_ID
    returning
      value(REPOSITORY_HEAD) type SCTS_AVCS_REPO .
  methods SET_CONFIG
    importing
      !REPOSITORY type SCTS_ABAP_VCS_REPOSITORY_ID
      !CONFIG type IF_CTS_ABAP_VCS_REPOSITORY=>TT_REPOSITORY_CONFIG
    returning
      value(R_CONFIG) type IF_CTS_ABAP_VCS_REPOSITORY=>TT_REPOSITORY_CONFIG .
  methods SET_CONFIG_BY_KEY
    importing
      !REPOSITORY type SCTS_ABAP_VCS_REPOSITORY_ID
      !KEY type SCTS_ABAP_VCS_CONFIG_KEY
      !VALUE type SCTS_ABAP_VCS_CONFIG_VALUE
    returning
      value(R_VALUE) type SCTS_ABAP_VCS_CONFIG_VALUE .
  methods GET_CONFIG_BY_KEY
    importing
      !REPOSITORY type SCTS_AVCS_SYSTEM_ID
      !KEY type SCTS_ABAP_VCS_CONFIG_KEY
    returning
      value(VALUE) type SCTS_ABAP_VCS_CONFIG_VALUE .
  methods SET_NAME
    importing
      !REPOSITORY type SCTS_ABAP_VCS_REPOSITORY_ID
      !NAME type SCTS_AVCS_REPO-NAME .
  methods SET_TYPE
    importing
      !REPOSITORY type SCTS_ABAP_VCS_REPOSITORY_ID
      !TYPE type SCTS_AVCS_REPO-TYPE .
  methods SET_VSID
    importing
      !REPOSITORY type SCTS_ABAP_VCS_REPOSITORY_ID
      !VSID type SCTS_AVCS_REPO-VSID .
  methods SET_PRIVATE_FLAG
    importing
      !REPOSITORY type SCTS_ABAP_VCS_REPOSITORY_ID
      !PRIVATE type SCTS_AVCS_REPO-PRIVATE_FLAG .
  methods SET_ROLE
    importing
      !REPOSITORY type SCTS_ABAP_VCS_REPOSITORY_ID
      !ROLE type SCTS_AVCS_REPO-ROLE .
  methods SET_BRANCH
    importing
      !REPOSITORY type SCTS_ABAP_VCS_REPOSITORY_ID
      !BRANCH type SCTS_AVCS_REPO-BRANCH .
  methods SET_STATUS
    importing
      !REPOSITORY type SCTS_ABAP_VCS_REPOSITORY_ID
      !STATUS type SCTS_AVCS_REPO-STATUS .
  methods SET_URL
    importing
      !REPOSITORY type SCTS_ABAP_VCS_REPOSITORY_ID
      !URL type SCTS_AVCS_REPO-URL .
  methods GET_CURRENT_COMMIT
    importing
      !REPOSITORY type SCTS_ABAP_VCS_REPOSITORY_ID
    returning
      value(COMMIT) type SCTS_ABAP_VCS_COMMIT_HASH .
  methods CREATE_REPOSITORY
    importing
      !REPOSITORY type SCTS_ABAP_VCS_REPOSITORY_ID
      !NAME type SCTS_AVCS_REPO-NAME
      !TYPE type SCTS_AVCS_REPO-TYPE
      !VSID type SCTS_AVCS_REPO-VSID
      !ROLE type SCTS_AVCS_REPO-ROLE
      !URL type SCTS_AVCS_REPO-URL
      !PRIVATE_FLAG type SCTS_AVCS_REPO-PRIVATE_FLAG
      !CONFIG type IF_CTS_ABAP_VCS_CONFIG_HANDLER=>TT_CONFIG optional
    returning
      value(RID) type SCTS_ABAP_VCS_REPOSITORY_ID .
  methods DELETE_REPOSITORY
    importing
      !REPOSITORY type SCTS_ABAP_VCS_REPOSITORY_ID
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods SET_HISTORY
    importing
      !REPOSITORY type SCTS_ABAP_VCS_REPOSITORY_ID
      !HISTORY type SCTS_AVCS_REPHIS
    returning
      value(R_HISTORY) type SCTS_AVCS_REPHIS .
  methods GET_HISTORY
    importing
      !REPOSITORY type SCTS_ABAP_VCS_REPOSITORY_ID
    returning
      value(HISTORY) type CL_CTS_ABAP_VCS_HISTORY=>TT_HISTORY .
  methods GET_CUSTOMIZING_OBJECTS
    importing
      !REPOSITORY type SCTS_ABAP_VCS_REPOSITORY_ID
      !COMMIT type SCTS_ABAP_VCS_COMMIT_HASH optional
      !BRANCH type SCTS_ABAP_VCS_BRANCH_NAME optional
    exporting
      value(CUSTOMIZING_OBJECTS) type TT_OBJECTS_CUSTOMIZING .
  methods GET_HISTORY_ENTRY
    importing
      !REPOSITORY type SCTS_ABAP_VCS_REPOSITORY_ID
      !FROM_COMMIT type SCTS_AVCS_REPHIS-FROM_COMMIT
      !TO_COMMIT type SCTS_AVCS_REPHIS-TO_COMMIT
      !CHECKOUT_TIME type SCTS_AVCS_REPHIS-CHECKOUT_TIME
    returning
      value(HISTORY) type SCTS_AVCS_REPHIS .
  methods GET_OBJECTS
    importing
      !REPOSITORY type SCTS_ABAP_VCS_REPOSITORY_ID
      !COMMIT type SCTS_ABAP_VCS_COMMIT_HASH optional
      !BRANCH type SCTS_ABAP_VCS_BRANCH_NAME optional
    returning
      value(OBJECTS) type TT_OBJECTS .
  methods SET_CUSTOMIZING_OBJECTS
    importing
      !REPOSITORY type SCTS_ABAP_VCS_REPOSITORY_ID
      !COMMIT type SCTS_ABAP_VCS_COMMIT_HASH
      !CUSTOMIZING_OBJECTS type TT_OBJECTS_CUSTOMIZING
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods SET_OBJECTS
    importing
      !REPOSITORY type SCTS_ABAP_VCS_REPOSITORY_ID
      !COMMIT type SCTS_ABAP_VCS_COMMIT_HASH
      !OBJECTS type TT_OBJECTS
    returning
      value(NEW_OBJECTS) type TT_OBJECTS
    raising
      CX_CTS_ABAP_VCS_EXCEPTION .
  methods PREPARE_TMS_CONFIG
    importing
      !JAVA_PATH type IF_CTS_ABAP_VCS_CONFIG_HANDLER=>TY_CONF_VALUE
      !JAR_PATH type IF_CTS_ABAP_VCS_CONFIG_HANDLER=>TY_CONF_VALUE
      !REPOSITORY type ref to IF_CTS_ABAP_VCS_REPOSITORY .
endinterface.