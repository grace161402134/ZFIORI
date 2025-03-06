
//Tujuan utamanya adalah menampilkan data perjalanan (travel) dari ZI_RAP_GRC_travel 
//dan membuatnya tersedia untuk aplikasi Fiori atau layanan OData.

//Anotasi Umum
@AccessControl.authorizationCheck: #CHECK  // Jika pengguna tidak memiliki hak akses, data tidak akan ditampilkan.
@EndUserText.label: 'Travel BO projection view' //Menentukan label yang akan muncul di UI Fiori.
@Search.searchable: true //Mengaktifkan fitur pencarian di Fiori.
@Metadata.allowExtensions: true 
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_RAP_GRC_TRAVEL // ini adalah entity utama dalam RAP.
  as projection on ZI_RAP_GRC_travel // Mengambil data dari ZI_RAP_GRC_travel dan menampilkan hanya field yang diperlukan.
{
    key TravelUuid, //primary key
    
    // TravelId dapat digunakan untuk pencarian default di Fiori.
    @Search.defaultSearchElement: true
    TravelId,
    
    //Field AgencyId akan memiliki dropdown yang mengambil data dari entity /DMO/I_Agency.
    @Consumption.valueHelpDefinition: [{ entity : { name: '/DMO/I_Agency', element: 'AgencyID'} }]
    @ObjectModel.text.element: ['AgencyName']
    @Search.defaultSearchElement: true
    AgencyId,
    _Agency.Name as AgencyName,
    
    //Menampilkan dropdown CustomerId yang mengambil data dari /DMO/I_Customer
    @Consumption.valueHelpDefinition: [{ entity : { name: '/DMO/I_Customer', element: 'CustomerID'}  }]
    @ObjectModel.text.element: [ 'CustomerName' ]
    @Search.defaultSearchElement: true
    CustomerId,
    _Customer.LastName as CustomerName,
    
    
    BeginDate,
    EndDate,
    @Semantics.amount.currencyCode: 'CurrencyCOde'
    BookingFee,
    @Semantics.amount.currencyCode: 'CurrencyCOde'
    TotalPrice,
    @Consumption.valueHelpDefinition: [{ entity : { name: 'I_Currency', element: 'Currency'} }]
    CurrencyCode,
    Description,
    OverallStatus,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    /* Associations */
    _Agency,
    
    // data Booking bisa otomatis muncul sebagai sub-entity dari Travel.
    _Booking : redirected to composition child ZC_RAP_GRC_BOOK,
    //apabila tidak memakai redirected (komposisi) maka harus manual seperti :
    //define view entity ZC_RAP_GRC_TRAVEL
   // as select from ZI_RAP_GRC_TRAVEL as Travel
   // left outer join ZI_RAP_GRC_BOOK as Booking //kenapa left outer join = karena Mengambil semua data dari Travel,
                                                 // meskipun tidak ada data di Booking.
                                                 // Jika tidak ada Booking, kolomnya akan NULL, tapi Travel tetap muncul.
                                                 // kalo right outer join kan, Mengambil semua data dari Booking, meskipun tidak ada Travel.
                                                 // Kalau pakai INNER JOIN, Travel yang belum ada Booking akan hilang!
   // on Travel.TravelUuid = Booking.TravelUuid
//   {
//    key Travel.TravelUuid,
//    Travel.TravelId,
//    Travel.Description,
//    Booking.BookingUuid,
//    Booking.BookingId,
//    Booking.CustomerId
//    }
    
    
    _Currency, 
    _Customer 
}
