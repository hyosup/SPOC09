@AbapCatalog.sqlViewName: 'ZVHRJTDLVSTATUS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help - 거절상태/납품상태'

@Search.searchable: true

@VDM: {
  viewType: #CONSUMPTION
}

@ObjectModel : {
  usageType.dataClass: #MASTER,
  usageType.serviceQuality: #A,
  usageType.sizeCategory: #XXL
}
define view Z_VH_EJTORDLVSTATUS as select from dd07t {
    key domvalue_l as Status,

      ddtext as StatusDesc
} where domname = 'STATV' 
    and ddlanguage = $session.system_language

