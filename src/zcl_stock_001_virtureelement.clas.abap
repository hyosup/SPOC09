CLASS zcl_stock_001_virtureelement DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sadl_exit .
    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_stock_001_virtureelement IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.
    LOOP AT it_original_data ASSIGNING FIELD-SYMBOL(<fs_original_data>).
      READ TABLE ct_calculated_data[] INDEX sy-tabix ASSIGNING FIELD-SYMBOL(<fs_calculated_data>).
      ASSIGN COMPONENT 'SALESORDER' OF STRUCTURE <Fs_original_data> TO FIELD-SYMBOL(<fs_salesorder>).
      ASSIGN COMPONENT 'CREDITCONTROLAREA' OF STRUCTURE <Fs_original_data> TO FIELD-SYMBOL(<fs_creditcontrolarea>).
      ASSIGN COMPONENT 'CUSTOMERCREDITACCOUNT' OF STRUCTURE <Fs_original_data> TO FIELD-SYMBOL(<fs_CUSTOMERCREDITACCOUNT>).

      "**********************************************************************
      " Value Inc. Tax Logic
      "**********************************************************************
      SELECT SINGLE
             SUM( kbmeng * cmpre ) AS amount
      FROM vbap
      INTO @DATA(lv_sum)
      WHERE vbeln = @<fs_salesorder>
      GROUP BY waerk.

      ASSIGN COMPONENT 'VALUEINCTAX' OF STRUCTURE <fs_calculated_data> TO FIELD-SYMBOL(<Fs_value>).
      <fs_value> = lv_sum.

      "**********************************************************************
      " Open orders
      "**********************************************************************
      SELECT SINGLE
             SUM( oeikw ) AS amount
      FROM s066
      INTO @DATA(lv_OEIKW_sum)
      WHERE knkli = @<fs_CUSTOMERCREDITACCOUNT>
        AND kkber = @<fs_creditcontrolarea>.

      ASSIGN COMPONENT 'OPENORDERS' OF STRUCTURE <fs_calculated_data> TO <Fs_value>.
      <fs_value> = lv_OEIKW_sum.

      "**********************************************************************
      " Open delivery
      "**********************************************************************
      SELECT SINGLE
             SUM( olikw ) AS amount
      FROM s067
      INTO @DATA(lv_OLIKW_sum)
      WHERE knkli = @<fs_CUSTOMERCREDITACCOUNT>
        AND kkber = @<fs_creditcontrolarea>.

      ASSIGN COMPONENT 'OPENDELIVERY' OF STRUCTURE <fs_calculated_data> TO <Fs_value>.
      <fs_value> = lv_OEIKW_sum.

      "**********************************************************************
      SELECT SINGLE kunnr, cashc, klimk, ssobl, skfor
      FROM knkk
      INTO @DATA(lS_knkk)
      WHERE kunnr = @<fs_CUSTOMERCREDITACCOUNT>
        AND kkber = @<fs_creditcontrolarea>.

      IF ls_knkk IS NOT INITIAL.
        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        " 총채권
        "**********************************************************************
        ASSIGN COMPONENT 'TOTALRECEIVABLES' OF STRUCTURE <fs_calculated_data> TO <Fs_value>.
        <fs_value> = lS_knkk-skfor.

        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        " 여신사용액 = 총채권 + 미결오더 + 미결납품 + 특별부채
        "**********************************************************************
        ASSIGN COMPONENT 'CREDITEXPOSURE' OF STRUCTURE <fs_calculated_data> TO <Fs_value>.
        DATA(lv_crdtexp) = lS_knkk-skfor + lv_OEIKW_sum + lv_olikw_sum + ls_knkk-ssobl.
        <fs_value> = lv_crdtexp.

        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        " 여신한도
        "**********************************************************************
        ASSIGN COMPONENT 'CREDITLIMIT' OF STRUCTURE <fs_calculated_data> TO <Fs_value>.
        <Fs_value> = ls_knkk-klimk.

        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        " 여신잔액 = 여신한도 - 여신사용액
        "**********************************************************************
        ASSIGN COMPONENT 'CREDITLIMITLEFT' OF STRUCTURE <fs_calculated_data> TO <Fs_value>.
        <fs_value> = ls_knkk-klimk - lv_crdtexp.

        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        " 여신잔액 = 여신한도 - 여신사용액
        "**********************************************************************
        ASSIGN COMPONENT 'CREDITLIMITLEFT' OF STRUCTURE <fs_calculated_data> TO <Fs_value>.
        <fs_value> = ls_knkk-klimk - lv_crdtexp.

        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        " 사용율 = 여신사용액/여신한도 (예:23.5%)
        "**********************************************************************
        IF ls_knkk-klimk <> 0.
          ASSIGN COMPONENT 'CREDITLIMITLEFT' OF STRUCTURE <fs_calculated_data> TO <Fs_value>.
          <fs_value> = lv_crdtexp / ls_knkk-klimk.
        ELSE.
          <fs_value> = 0.
        ENDIF.

        "**********************************************************************
        " Credit Currency
        "**********************************************************************
        SELECT SINGLE kunnr, waers
          FROM knka
          INTO @DATA(lS_KNKA)
          WHERE kunnr = @<fs_CUSTOMERCREDITACCOUNT>.

        ASSIGN COMPONENT 'CREDITCURRENCY' OF STRUCTURE <fs_calculated_data> TO <Fs_value>.
        IF lS_knkk-cashc IS NOT INITIAL.
          <Fs_value> = lS_knkk-cashc.
        ELSEIF ls_knka IS NOT INITIAL.
          <Fs_value> = ls_knka-waers.
        ENDIF.

      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
  ENDMETHOD.
ENDCLASS.
