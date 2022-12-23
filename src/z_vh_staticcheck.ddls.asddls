@AbapCatalog.sqlViewName: 'ZVHSTATICCHECK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help - 여신'


@VDM: {
  viewType: #CONSUMPTION
}

@ObjectModel : {
  usageType.dataClass: #MASTER,
  usageType.serviceQuality: #A,
  usageType.sizeCategory: #XXL
}
define view Z_VH_STATICCHECK as select from dd07t {
    key domvalue_l as StaticCheck,

      ddtext as StaticCheckDesc
} where domname = 'CMPSZ' 
    and ddlanguage = $session.system_language

