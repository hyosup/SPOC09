@AbapCatalog.sqlViewAppendName: 'ZXPURCHORDERTP'
@EndUserText.label: '[Poc] 구매오더 관리 확장'
extend view C_PurchaseOrderTP with ZE_PurchaseOrderTP_0010 
  association [0..1] to I_Employee as _CreatedBy on $projection.CreatePersonNo = _CreatedBy.PersonnelNumber
  association [0..1] to I_Employee as _ChangedBy on $projection.ChangePersonNo = _ChangedBy.PersonnelNumber {
    ZZ1_CreatePersonNo_PDH as CreatePersonNo,
    
    @ObjectModel.readOnly: true
    _CreatedBy.EmployeeFullName as CreatePersonName,
    
    ZZ1_ChangePersonNo_PDH as ChangePersonNo,
    
    @ObjectModel.readOnly: true
    _ChangedBy.EmployeeFullName as ChangePersonName,
    
    _CreatedBy,
    
    _ChangedBy
}
