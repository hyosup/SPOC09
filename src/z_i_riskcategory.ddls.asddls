@AbapCatalog.sqlViewName: 'ZIRISKCATEGORY'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RiskCategory Value Help Text'
define view Z_I_RiskCategory as select from t691t 
{
    @EndUserText.label: '리스크범주'
    @EndUserText.quickInfo: '리스크범주'
    key ctlpc,
    
    @EndUserText.label: '여신관리영역'
    @EndUserText.quickInfo: '여신관리영역'
    key kkber,
    
    @EndUserText.label: '리스크범주내역'
    @EndUserText.quickInfo: '리스크범주내역'
    key rtext,
    
    @EndUserText.label: '언어키'
    @EndUserText.quickInfo: '언어키'
    spras
}
