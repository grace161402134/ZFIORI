CLASS zcl_grc_first DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
**
    INTERFACES if_oo_adt_classrun. "sent as a parameter to the service "ADT"(from SICF) as a HTTP request.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_GRC_FIRST IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main. "entry point (metode utama)
    out->write( |Hello World!! ({ cl_abap_context_info=>get_user_alias( ) })| ).
** OUT =  parameter output bawaan dari interface if_oo_adt_classrun
** write = digunakan untuk mencetak teks ke output (log konsol).
** { cl_abap_context_info=>get_user_alias( ) } digunakan untuk menampilkan user alias yang aktif.
  ENDMETHOD.
ENDCLASS.
