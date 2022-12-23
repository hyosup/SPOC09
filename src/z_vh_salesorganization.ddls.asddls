@AbapCatalog.sqlViewName: 'ZVHSALESORGAN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help - 영업조직'

@Search.searchable: true

@VDM: {
  viewType: #CONSUMPTION
}

@ObjectModel : {
  usageType.dataClass: #MASTER,
  usageType.serviceQuality: #A,
  usageType.sizeCategory: #XXL
}
define view Z_VH_SALESORGANIZATION as select from I_SalesOrganization {
    key SalesOrganization,

      _Text[1:Language=$session.system_language].SalesOrganizationName
}
