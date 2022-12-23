@AbapCatalog.sqlViewName: 'ZISOHEADSTATUS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '판매 문서: 헤더 상태 및 관리 데이터'
define view Z_I_SO_HEAD_STATUS
  as select from vbuk
{
  key vbeln,
      cmpsa
}
