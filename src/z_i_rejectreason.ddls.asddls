@AbapCatalog.sqlViewName: 'ZIREJREASON'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RejectReason Value Help Text'
define view Z_I_RejectReason as select from tvagt
{
    @EndUserText.label: '판매문서거부사유'
    @EndUserText.quickInfo: '판매문서거부사유'
    key abgru,
    
    @EndUserText.label: '내역'
    @EndUserText.quickInfo: '내역'
    bezei,
    
    @EndUserText.label: '언어키'
    @EndUserText.quickInfo: '언어키'
    spras
}
