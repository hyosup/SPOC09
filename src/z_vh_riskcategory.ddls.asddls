@AbapCatalog.sqlViewName: 'ZVHRISKCATEGORY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help - 리스크'

@Search.searchable: true

@VDM: {
  viewType: #CONSUMPTION
}

@ObjectModel : {
  usageType.dataClass: #MASTER,
  usageType.serviceQuality: #A,
  usageType.sizeCategory: #XXL
}
define view Z_VH_RISKCATEGORY as select from Z_I_RiskCategory {
    
    key ctlpc,
    
    key kkber,
    
    rtext
    
} where spras = $session.system_language
