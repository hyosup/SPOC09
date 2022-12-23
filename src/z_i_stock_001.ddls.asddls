@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '장기미결 오더 리스트'

define root view entity Z_I_STOCK_001
  as select from I_SalesOrderCube( P_ExchangeRateType: 'M', P_DisplayCurrency: 'KRW')
  association [0..1] to I_SalesDocument     as _SalesDoc   on $projection.SalesOrder = _SalesDoc.SalesDocument
  association [0..1] to Z_I_SO_HEAD_STATUS  as _Status     on $projection.SalesOrder = _Status.vbeln
  association [0..1] to VC_INTEGRATION_VBAK as _Extraction on $projection.SalesOrder = _Extraction.VBELN
{
      @EndUserText.label: '판매오더번호'
      @EndUserText.quickInfo: '판매오더번호'
  key SalesOrder,

      @EndUserText.label: '생성일'
      @EndUserText.quickInfo: '생성일'
      SalesOrderDate,

      @EndUserText.label: '유형'
      @EndUserText.quickInfo: '유형'
      SalesOrderType,

      @EndUserText.label: '영업조직'
      @EndUserText.quickInfo: '영업조직'
      SalesOrganization,

      @EndUserText.label: '유통경로'
      @EndUserText.quickInfo: '유통경로'
      DistributionChannel,

      @EndUserText.label: '제품군'
      @EndUserText.quickInfo: '제품군'
      OrganizationDivision,

      @EndUserText.label: '사업장'
      @EndUserText.quickInfo: '사업장'
      SalesOffice,

      @EndUserText.label: '영업그룹'
      @EndUserText.quickInfo: '영업그룹'
      SalesGroup,

      @EndUserText.label: '거절'
      @EndUserText.quickInfo: '거절'
      OverallSDDocumentRejectionSts,

      @EndUserText.label: '여신'
      @EndUserText.quickInfo: '여신'
      _Status.cmpsa                                        as StaticCheckSts,

      @EndUserText.label: '납품'
      @EndUserText.quickInfo: '납품'
      OverallDeliveryStatus,

      @EndUserText.label: '생성자'
      @EndUserText.quickInfo: '생성자'
      CreatedByUser,

      @EndUserText.label: '판매처'
      @EndUserText.quickInfo: '판매처'
      SoldToParty,

      @EndUserText.label: '판매처명'
      @EndUserText.quickInfo: '판매처명'
      _SalesDoc._SoldToParty.OrganizationBPName1           as SoldToPartyName,

      @EndUserText.label: '여신계정'
      @EndUserText.quickInfo: '여신계정'
      _SalesDoc.CustomerCreditAccount,

      @EndUserText.label: '여신계정명'
      @EndUserText.quickInfo: '여신계정명'
      _SalesDoc._CustomerCreditAccount.OrganizationBPName1 as CustomerCreditAccountName,

      @EndUserText.label: '리스크'
      @EndUserText.quickInfo: '리스크'
      _Extraction.CTLPC                                    as Risk,

      @EndUserText.label: '화폐'
      @EndUserText.quickInfo: '화폐'
      TransactionCurrency,

      @EndUserText.label: '가격 결정일'
      @EndUserText.quickInfo: '가격 결정일'
      PricingDate,
      
      _SalesDoc.CreditControlArea,

      _SalesDoc,

      _Status,

      _Extraction

}
