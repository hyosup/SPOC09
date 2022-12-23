@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '장기미결 오더 리스트 - Projection View'

@Metadata.allowExtensions: true

define root view entity Z_C_STOCK_001
  as projection on Z_I_STOCK_001
{

  key     SalesOrder,

          SalesOrderDate,

          @Consumption.valueHelpDefinition: [{ entity: { name:  'Z_VH_SALESDOCUMENTTYPE',
                                                         element: 'SalesDocumentType'} }]
          SalesOrderType,


          @Consumption.valueHelpDefinition: [{ entity: { name:  'Z_VH_SALESORGANIZATION',
                                                         element: 'SalesOrganization'} }]
          SalesOrganization,

          @Consumption.valueHelpDefinition: [{ entity: { name:  'Z_VH_DISTRIBUTION_CHANNEL',
                                                         element: 'DistributionChannel'} }]
          DistributionChannel,

          @Consumption.valueHelpDefinition: [{ entity: { name:  'Z_VH_DIVISION',
                                                         element: 'Division'} }]
          OrganizationDivision,

          @Consumption.valueHelpDefinition: [{ entity: { name:  'Z_VH_SALESOFFICE',
                                                         element: 'SalesOffice'} }]
          SalesOffice,

          @Consumption.valueHelpDefinition: [{ entity: { name:  'Z_VH_SALESGROUP',
                                                         element: 'SalesGroup'} }]
          SalesGroup,

          @Consumption.valueHelpDefinition: [{ entity: { name:  'Z_VH_EJTORDLVSTATUS',
                                                         element: 'Status'} }]
          OverallSDDocumentRejectionSts,

          @Consumption.valueHelpDefinition: [{ entity: { name:  'Z_VH_STATICCHECK',
                                                   element: 'StaticCheck'} }]
          StaticCheckSts,

          @Consumption.valueHelpDefinition: [{ entity: { name:  'Z_VH_EJTORDLVSTATUS',
                                                         element: 'Status'} }]
          OverallDeliveryStatus,

          CreatedByUser,

          @ObjectModel.text.element: ['SoldToPartyName']
          SoldToParty,

          SoldToPartyName,

          @ObjectModel.text.element: ['CustomerCreditAccountName']
          CustomerCreditAccount,

          CustomerCreditAccountName,

          Risk,

          TransactionCurrency,

          PricingDate,
          
          CreditControlArea,

          @ObjectModel.virtualElement: true
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_STOCK_001_VIRTUREELEMENT'
          @Semantics.amount.currencyCode: 'TransactionCurrency'
          @EndUserText.label: '오더 금액'
          @EndUserText.quickInfo: '오더 금액'
  virtual ValueIncTax      : netwr,

          @ObjectModel.virtualElement: true
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_STOCK_001_VIRTUREELEMENT'
          @EndUserText.label: '여신한도 통화키'
          @EndUserText.quickInfo: '여신한도 통화키'
  virtual CreditCurrency   : cashc,

          @ObjectModel.virtualElement: true
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_STOCK_001_VIRTUREELEMENT'
          @Semantics.amount.currencyCode: 'CreditCurrency'
          @EndUserText.label: '여신한도'
          @EndUserText.quickInfo: '여신한도'
  virtual CreditLimit      : klimk,

          @ObjectModel.virtualElement: true
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_STOCK_001_VIRTUREELEMENT'
          @Semantics.amount.currencyCode: 'CreditCurrency'
          @EndUserText.label: '여신잔액'
          @EndUserText.quickInfo: '여신잔액'
  virtual CreditLimitLeft  : klimk,

          @ObjectModel.virtualElement: true
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_STOCK_001_VIRTUREELEMENT'
          @EndUserText.label: '사용율'
          @EndUserText.quickInfo: '사용율'
  virtual CredLimUsed      : klprz_cm,

          @ObjectModel.virtualElement: true
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_STOCK_001_VIRTUREELEMENT'
          @Semantics.amount.currencyCode: 'CreditCurrency'
          @EndUserText.label: '여신사용액'
          @EndUserText.quickInfo: '여신사용액'
  virtual CreditExposure   : skfor,

          @ObjectModel.virtualElement: true
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_STOCK_001_VIRTUREELEMENT'
          @Semantics.amount.currencyCode: 'CreditCurrency'
          @EndUserText.label: '총채권'
          @EndUserText.quickInfo: '총채권'
  virtual TotalReceivables : skfor,

          @ObjectModel.virtualElement: true
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_STOCK_001_VIRTUREELEMENT'
          @Semantics.amount.currencyCode: 'CreditCurrency'
          @EndUserText.label: '미결오더'
          @EndUserText.quickInfo: '미결오더'
  virtual OpenOrders       : mc_oeikw,

          @ObjectModel.virtualElement: true
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_STOCK_001_VIRTUREELEMENT'
          @Semantics.amount.currencyCode: 'CreditCurrency'
          @EndUserText.label: '미결납품'
          @EndUserText.quickInfo: '미결납품'
  virtual OpenDelivery     : mc_oeikw


}
