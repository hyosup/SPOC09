@AbapCatalog.sqlViewName: 'ZVHDISTCHNL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help - 유통경로'

@Search.searchable: true

@VDM: {
  viewType: #CONSUMPTION
}

@ObjectModel : {
  usageType.dataClass: #MASTER,
  usageType.serviceQuality: #A,
  usageType.sizeCategory: #XXL
}
define view Z_VH_DISTRIBUTION_CHANNEL as select from I_DistributionChannel {
    key DistributionChannel,

      _Text[1:Language=$session.system_language].DistributionChannelName
}
