@EndUserText.label: '전체 거절 Action Input'
define abstract entity Z_AE_REJECT_INPUT
{
  @EndUserText.label: '거절사유'
  @EndUserText.quickInfo: '거절사유'
  @Consumption.valueHelpDefinition: [{ entity: { name:  'Z_VH_REJECTREASON',
                                                    element: 'Status'} }]
  rejectReason : abgru;
}
