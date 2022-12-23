@AbapCatalog.sqlViewName: 'ZVHSDTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help - 주문유형'

@Search.searchable: true

@VDM: {
  viewType: #CONSUMPTION
}

@ObjectModel : {
  usageType.dataClass: #MASTER,
  usageType.serviceQuality: #A,
  usageType.sizeCategory: #XXL
}

define view Z_VH_SALESDOCUMENTTYPE
  as select from I_SalesDocumentType
{
  key SalesDocumentType,

      _Text[1:Language=$session.system_language].SalesDocumentTypeName

}
