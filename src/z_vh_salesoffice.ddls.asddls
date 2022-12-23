@AbapCatalog.sqlViewName: 'ZVHSALESOFFICE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help - 사업장'

@Search.searchable: true

@VDM: {
  viewType: #CONSUMPTION
}

@ObjectModel : {
  usageType.dataClass: #MASTER,
  usageType.serviceQuality: #A,
  usageType.sizeCategory: #XXL
}
define view Z_VH_SALESOFFICE as select from I_SalesOffice {
    key SalesOffice,

      _Text[1:Language=$session.system_language].SalesOfficeName
}
