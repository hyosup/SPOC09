@AbapCatalog.sqlViewName: 'ZVHREJECTREASON'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help - 거절사유'

@Search.searchable: true

@VDM: {
  viewType: #CONSUMPTION
}

@ObjectModel : {
  usageType.dataClass: #MASTER,
  usageType.serviceQuality: #A,
  usageType.sizeCategory: #XXL
}
define view Z_VH_REJECTREASON as select from Z_I_RejectReason
{

  key abgru as Status,

      bezei as StatusDesc

} where spras = $session.system_language
