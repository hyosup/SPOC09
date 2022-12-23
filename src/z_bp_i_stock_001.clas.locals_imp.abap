CLASS lhc_stock DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE stock.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE stock.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE stock.

    METHODS read FOR READ
      IMPORTING keys FOR READ stock RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK stock.

    METHODS rejectall FOR MODIFY
      IMPORTING it_input FOR ACTION stock~rejectall.

    METHODS reprice FOR MODIFY
      IMPORTING it_input FOR ACTION stock~reprice RESULT result.

ENDCLASS.



CLASS lhc_stock IMPLEMENTATION.

  METHOD create.
  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD rejectall.
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Value Check
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    DATA : lt_salesorderitem TYPE TABLE FOR ACTION IMPORT r_salesorderitemtp~setrejectionreason.

    LOOP AT it_input[] INTO DATA(ls_input).

      IF ls_input-%param-rejectreason IS INITIAL.
        APPEND INITIAL LINE TO reported-stock ASSIGNING FIELD-SYMBOL(<fs_reported>).

        DATA(lo_msg01) = new_message_with_text(
             severity = if_abap_behv_message=>severity-error
             text       = '거절 사유를 선택해주세요' ).

        <fs_reported>-%msg = lo_msg01.
        <fs_reported>-%element-overallsddocumentrejectionsts     = if_abap_behv=>mk-on.
        <fs_reported>-%action-rejectall = if_abap_behv=>mk-on.
        EXIT.
      ENDIF.


      READ ENTITIES OF i_salesordertp
           ENTITY salesorder BY \_item
             ALL FIELDS WITH VALUE #( ( %key-salesorder = ls_input-%key-salesorder ) )
           LINK DATA(lt_link)
           RESULT DATA(lt_result)
           FAILED DATA(lt_failed)
           REPORTED DATA(lt_reported).

      LOOP AT lt_result ASSIGNING FIELD-SYMBOL(<fs_result>) WHERE deliverystatus = 'A'.
        APPEND INITIAL LINE TO lt_salesorderitem ASSIGNING FIELD-SYMBOL(<fs_salesorderitem>).
        <fs_salesorderitem>-salesorder = <fs_result>-salesorder.
        <fs_salesorderitem>-salesorderitem = <fs_result>-salesorderitem.
        <fs_salesorderitem>-%param-salesdocumentrjcnreason = ls_input-%param-rejectreason.
      ENDLOOP.

      IF lt_salesorderitem IS NOT INITIAL.

        MODIFY ENTITIES OF r_salesordertp
                ENTITY salesorderitem
                  EXECUTE setrejectionreason FROM lt_salesorderitem
                  MAPPED   DATA(ls_mapped)
                  FAILED   DATA(ls_failed)
                  REPORTED DATA(ls_reported).

        IF ls_failed IS NOT INITIAL.
          APPEND INITIAL LINE TO failed-stock ASSIGNING FIELD-SYMBOL(<ls_failed>).
          <ls_failed>-%action-rejectall = 'X'.
          LOOP AT ls_failed-salesorderitem ASSIGNING FIELD-SYMBOL(<fs_failed_salesorderitem>).
            MOVE-CORRESPONDING <fs_failed_salesorderitem> TO <ls_failed>.
          ENDLOOP.
        ENDIF.

        IF ls_failed IS INITIAL.
          APPEND INITIAL LINE TO reported-stock ASSIGNING <fs_reported>.

          DATA(lo_msg02) = new_message_with_text(
               severity = if_abap_behv_message=>severity-success
               text       = 'Reject All Success' ).

          <fs_reported>-%msg = lo_msg02.
          <fs_reported>-%element-overalldeliverystatus = if_abap_behv=>mk-on.
          <fs_reported>-%action-rejectall = if_abap_behv=>mk-on.
        ENDIF.

      ELSE.
        APPEND INITIAL LINE TO reported-stock ASSIGNING <fs_reported>.
        DATA(lo_msg03) = new_message_with_text(
             severity = if_abap_behv_message=>severity-error
             text       = '납품이 일부 처리되었거나 모두 처리되어 거절 사유 변경이 불가능합니다.' ).

        <fs_reported>-%msg = lo_msg03.
        <fs_reported>-%element-overallsddocumentrejectionsts     = if_abap_behv=>mk-on.
        <fs_reported>-%action-rejectall = if_abap_behv=>mk-on.
        EXIT.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.



  METHOD reprice.

    LOOP AT it_input[] INTO DATA(ls_input).
      IF ls_input-%param-repricedate IS INITIAL.
        APPEND INITIAL LINE TO reported-stock ASSIGNING FIELD-SYMBOL(<fs_reported>).

        DATA(lo_msg01) = new_message_with_text(
             severity = if_abap_behv_message=>severity-error
             text       = '가격 결정일을 선택해주세요' ).

        <fs_reported>-%msg = lo_msg01.
        <fs_reported>-%element-overallsddocumentrejectionsts     = if_abap_behv=>mk-on.
        <fs_reported>-%action-rejectall = if_abap_behv=>mk-on.
        EXIT.
      ENDIF.

      MODIFY ENTITIES OF i_salesordertp
         ENTITY salesorder
           UPDATE FIELDS ( pricingdate )
           WITH VALUE #( ( salesorder = ls_input-salesorder
                           pricingdate = ls_input-%param-repricedate ) )
           FAILED DATA(lt_failed)
           REPORTED DATA(lt_reported).

      IF lt_failed IS NOT INITIAL.
        APPEND INITIAL LINE TO failed-stock ASSIGNING FIELD-SYMBOL(<ls_failed>).
        <ls_failed>-%action-rejectall = 'X'.
        LOOP AT lt_failed-salesorderitem ASSIGNING FIELD-SYMBOL(<fs_failed_salesorderitem>).
          MOVE-CORRESPONDING <fs_failed_salesorderitem> TO <ls_failed>.
        ENDLOOP.
      ENDIF.


      IF lt_failed IS INITIAL.
        APPEND INITIAL LINE TO reported-stock ASSIGNING <fs_reported>.

        DATA(lo_msg02) = new_message_with_text(
             severity = if_abap_behv_message=>severity-success
             text       = 'Reprice Seuccess' ).

        "<fs_reported>-salesorder = ls_input-salesorder.

        <fs_reported>-%msg = lo_msg02.
        <fs_reported>-%element-pricingdate = if_abap_behv=>mk-on.
        <fs_reported>-%action-reprice = if_abap_behv=>mk-on.


        APPEND INITIAL LINE TO mapped-stock ASSIGNING FIELD-SYMBOL(<fs_mapped>).
        <fs_mapped>-salesorder = ls_input-salesorder.
      ENDIF.

      APPEND INITIAL LINE TO result[] ASSIGNING FIELD-SYMBOL(<fs_result>).
      <fs_result>-%key-SalesOrder    = ls_input-%key-SalesOrder.
      <fs_result>-salesorder         = ls_input-salesorder.
      <fs_result>-%param-repricedate = ls_input-%param-repricedate.
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
