CLASS zcl_rap_eml_grc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_RAP_EML_GRC IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*    "step 1 - READ
*    READ ENTITIES OF zi_Rap_grc_travel
*        ENTITY Travel
*            FROM VALUE #( ( TravelUUID = '5C9FE8D58FD04C311900AD62CC64C96A' ) )
*          RESULT data(travels).
*
*      out->write( travels ).

*    "step 2 - READ with fields
*    READ ENTITIES OF ZI_RAP_GRC_TRAVEL
*        ENTITY travel
*            FIELDS ( AgencyID CustomerID )
*        WITH VALUE #( ( TravelUuid = '5C9FE8D58FD04C311900AD62CC64C96A') )
*        RESULT DATA(travels).
*
*        out->write( travels ).
*
*      "step 4 - READ by Association
*      READ ENTITIES OF ZI_RAP_grc_Travel
*      ENTITY travel BY \_Booking
*        ALL FIELDS WITH VALUE #( ( TravelUUID = '5C9FE8D58FD04C311900AD62CC64C96A' ) )
*        RESULT DATA(bookings).
*
*        out->write( bookings ).

    "step 5 - unsuccessful READ
*   READ ENTITIES OF ZI_RAP_grc_Travel
*      ENTITY travel
*        ALL FIELDS WITH VALUE #( ( TravelUUID = '11111111111111111111' ) )
*        RESULT DATA(travels)
*        FAILED DATA(failed)
*        REPORTED DATA(reported).
*
*        out->write( travels ).
*        out->write( failed ). "complex structures not supported by the console output
*        out->write( reported ). "complex structures not supported by the console output

*    "step 6 - MODIFY Update
*    "Kode ini memperbarui field Description dalam tabel ZI_RAP_GRC_TRAVEL berdasarkan TravelUUID.
*    MODIFY ENTITIES OF ZI_RAP_GRC_TRAVEL
*    ENTITY travel           "Menentukan Entitas Yang Ingin Diperbarui
*    UPDATE
*    SET FIELDS WITH VALUE " Menentukan nilai baru yang akan digunakan untuk memperbarui entitas.
*    #( ( TravelUUID = '5C9FE8D58FD04C311900AD62CC64C96A'
*         Description = 'RAP@ipenSAP') )
*
*      FAILED DATA(failed) "Berguna untuk error handling
*      REPORTED DATA(reported).
*
*      out->write( 'Update done' ).
*
*    "step 6b - Commit Entities
*    COMMIT ENTITIES
*        RESPONSE OF ZI_RAP_GRC_TRAVEL
*        FAILED DATA(failed_commit)
*        REPORTED DATA(reported_commit).

*    " step 7 - Modify Create
*    MODIFY ENTITIES OF ZI_RAP_GRC_TRAVEL
*    ENTITY travel
*    CREATE
*    SET FIELDS WITH VALUE
*    #( ( %cid  = 'MyContentID_1'
*        AgencyID = '70012'
*        CustomerID = '14'
*        BeginDate = cl_abap_context_info=>get_system_date(  )
*        EndDate  = cl_abap_context_info=>get_system_date(  ) + 10 "(tanggal sistem saat ini), dengan EndDate ditambahkan 10 hari.
*        Description = 'RAP@openSAP' ) )
*
*        MAPPED DATA(mapped) "Menangkap data yang berhasil dipetakan
*        FAILED DATA(failed) "Menangkap data yang gagal
*        REPORTED DATA(reported). "Menangkap informasi terkait dengan entitas yang berhasil dibuat dalam variabel reported.
*
*        out->write( mapped-travel ). " Menampilkan entitas travel yang telah berhasil dibuat dalam variabel mapped.
*
*        COMMIT ENTITIES
*            RESPONSE OF zi_rap_grc_travel
*            FAILED DATA(failed_commit)
*            REPORTED DATA(reported_commit).
*
*            out->write( 'Create Done' ).

        "step 8 - Modify Delete'
        MODIFY ENTITIES OF zi_rap_grc_travel
        ENTITY travel
        DELETE FROM
        VALUE
        #( ( TravelUUID = '5D9FE8D58FD04C311900AD62CC64C96A' ) )

        FAILED DATA(failed)
        REPORTED DATA(reported).

        COMMIT ENTITIES
        RESPONSE OF zi_rap_grc_travel
        FAILED DATA(failed_commit)
        REPORTED DATA(reported_commit).

        out->write( 'Delete Done' ).

  ENDMETHOD.
ENDCLASS.
