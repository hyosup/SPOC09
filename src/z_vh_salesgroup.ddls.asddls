@AbapCatalog.sqlViewName: 'ZVHSALESGRP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help - 영업그룹'

@Search.searchable: true

@VDM: {
  viewType: #CONSUMPTION
}

@ObjectModel : {
  usageType.dataClass: #MASTER,
  usageType.serviceQuality: #A,
  usageType.sizeCategory: #XXL
}
define view Z_VH_SALESGROUP as select from I_SalesGroup {
    key SalesGroup,

      _Text[1:Language=$session.system_language].SalesGroupName
}
