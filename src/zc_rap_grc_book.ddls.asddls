
//Menampilkan data pemesanan (booking) dari ZI_RAP_GRC_BOOK.

@AccessControl.authorizationCheck: #CHECK //Memeriksa otorisasi pengguna sebelum menampilkan data.
@EndUserText.label: 'Booking BO Projection View' //Menentukan label tampilan di UI Fiori.
@Search.searchable: true //Memungkinkan pencarian dalam Fiori Elements.
@Metadata.ignorePropagatedAnnotations: true // Mencegah pewarisan anotasi dari entitas lain.
@Metadata.allowExtensions: true //Memungkinkan ekstensi di masa depan tanpa perubahan besar.

// CDS Projection View.
//Mengambil data dari ZI_RAP_GRC_BOOK dengan alias Booking.
define view entity ZC_RAP_GRC_BOOK
as projection on ZI_RAP_GRC_BOOK as Booking
{
    key BookingUuid, //Primary key unik untuk setiap booking.
    TravelUuid, //Foreign key yang menghubungkan booking dengan travel tertentu.
    @Search.defaultSearchElement: true    //Mengaktifkan pencarian berdasarkan BookingId
    BookingId,
    BookingDate,
    
//**********************************************************//    
    //Saat user memilih CustomerId, data diambil dari entity /DMO/I_Customer.
    //Field yang digunakan sebagai referensi adalah CustomerID dari /DMO/I_Customer.    
    //Menyediakan Value Help (F4) untuk CustomerId.
    @Consumption.valueHelpDefinition: [{ entity : {name: '/DMO/I_Customer', element: 'CustomerID'} }]
    @ObjectModel.text.element: [ 'CustomerName' ]
    @Search.defaultSearchElement: true
    CustomerId,
    _Customer.LastName as CustomerName,
    //Saat CustomerId ditampilkan di UI Fiori, CustomerName akan muncul sebagai deskripsi tambahan.
    //contoh : Saat memilih CustomerId = 100001, UI akan otomatis menampilkan John Doe di field CustomerName.
    // demikian juga, Jika _Customer.LastName bernilai 'John Doe', maka CustomerName = 'John Doe'.
//**********************************************************//

    @Consumption.valueHelpDefinition: [{entity: {name: '/DMO/I_Carrier', element: 'AirlineID'}  }]
    @ObjectModel.text.element: [ 'CarrierName' ]
    CarrierId,
    _Carrier.Name as CarrierName,
    @Consumption.valueHelpDefinition: [{entity: {name: '/DMO/I_Flight', element: 'ConnectionID'},
                                      //Menggunakan additionalBinding untuk memfilter data penerbangan berdasarkan CarrierID.
                                     //Saat user memilih ConnectionId melalui F4 (Value Help), 
                                    //sistem akan menampilkan daftar penerbangan dari /DMO/I_Flight, tetapi juga akan:
                                   //Mengikat (bind) CarrierID dengan AirlineID. Mengambil nilai otomatis untuk:
                                  // FlightDate dari FlightDate di I_Flight.
                                 //FlightPrice dari Price di I_Flight.
                                //CurrencyCode dari CurrencyCode di I_Flight.
                                        additionalBinding: [{ localElement: 'CarrierID', element: 'AirlineID' },
                                                            { localElement: 'FlightDate', element: 'FlightDate', usage: #RESULT},
                                                            { localElement: 'FlightPrice', element: 'Price', usage: #RESULT},
                                                            { localElement: 'CurrencyCode', element: 'CurrencyCode', usage: #RESULT} ] }]
    ConnectionId,
    FlightDate,
    
    //Menandakan bahwa FlightPrice menggunakan CurrencyCode.
    @Semantics.amount.currencyCode: 'CurrencyCode'
    FlightPrice,
   
    //Dropdown CurrencyCode mengambil daftar mata uang dari I_Currency.
    @Consumption.valueHelpDefinition: [{entity: {name: 'I_Currency', element: 'Currency'}}]
    CurrencyCode,
    
    //Menyimpan informasi tentang siapa yang membuat/mengubah data.
    //Waktu terakhir perubahan data secara lokal.
    CreatedBy,
    LastChangedBy,
    LocalLasChangedAt,
    
    /* Associations */
    
    //_Travel adalah association ke entitas ZC_RAP_GRC_TRAVEL (parent).
    // redirected to parent, kita bisa langsung mengakses data dari parent (ZC_RAP_GRC_TRAVEL).
    _Travel : redirected to parent ZC_RAP_GRC_TRAVEL, //Menandakan bahwa booking terhubung ke entitas travel One-to-Many
    //setiap Booking terkait dengan satu Travel, sementara satu Travel bisa memiliki banyak Booking
    //Parent View (ZC_RAP_GRC_TRAVEL)
    //Child View (ZC_RAP_GRC_BOOK)
    // tanpa redirect to parent, maka harus join manual
    //SELECT B.BookingId, T.TravelId
    //FROM ZC_RAP_GRC_BOOK B
    //JOIN ZC_RAP_GRC_TRAVEL T ON B.TravelUuid = T.TravelUuid
    //Dengan redirected to parent, kita cukup menulis:
    //SELECT BookingId, _Travel.TravelId FROM ZC_RAP_GRC_BOOK
    
    
    _Customer,
    _Carrier,
    _Connection,    
    _Flight
    
}
