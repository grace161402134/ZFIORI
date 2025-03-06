
//Program ini mendefinisikan CDS View Entity untuk data pemesanan tiket penerbangan (Booking).

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED   
}
// Hubungan Parent-Child → Setiap pemesanan (ZI_RAP_GRC_BOOK) harus terkait dengan satu perjalanan (ZI_RAP_GRC_TRAVEL).
define view entity ZI_RAP_GRC_BOOK //Membuat CDS View dengan fitur RAP (RESTful ABAP Programming).
    as select from zrap_grc_booking
    // Menghubungkan ZI_RAP_GRC_BOOK dengan ZI_RAP_GRC_travel (Travel Header Data)
    // Menggunakan UUID (TravelUuid) sebagai foreign key
    association to parent ZI_RAP_GRC_travel as _Travel on $projection.TravelUuid = _Travel.TravelUuid
   //Parent Association berarti ZI_RAP_GRC_travel adalah entity induk, dan ZI_RAP_GRC_BOOK adalah anaknya
//*************************************************************************************************************//    

    //Hubungan One-to-One ([1..1]) antara Booking dan Customer
    // satu data di tabel A hanya bisa berhubungan dengan satu data di tabel B dan sebaliknya.
    // I_Customer adalah entity dari SAP Standard
    
    //Setiap pemesanan harus memiliki satu pelanggan.
    association [1..1] to /DMO/I_Customer as _Customer on $projection.CustomerId = _Customer.CustomerID
    //One-to-One ([1..1]) antara Booking dan Maskapai. CarrierId adalah kode airline/maskapai dalam data penerbangan
    association [1..1] to /DMO/I_Carrier as _Carrier on $projection.CarrierId = _Carrier.AirlineID
    // One-to-One ([1..1]) antara Booking dan Koneksi/Rute Penerbangan. CarrierId + ConnectionId digunakan untuk mengidentifikasi rute penerbangan
    association [1..1] to /DMO/I_Connection as _Connection on $projection.CarrierId = _Connection.AirlineID
                                                            and $projection.ConnectionId = _Connection.ConnectionID 
                                                               
    association [1..1] to /DMO/I_Flight as _Flight on $projection.CarrierId = _Flight.AirlineID
                                                   and $projection.ConnectionId = _Flight.ConnectionID
                                                   and $projection.FlightDate = _Flight.FlightDate
    //Hubungan Zero-to-One ([0..1]), artinya data Currency bisa ada atau tidak ada
    //CurrencyCode mengacu pada tabel mata uang I_Currency
    association [0..1] to I_Currency as _Currency on $projection.CurrencyCode = _Currency.Currency
{
    key booking_uuid as BookingUuid, //primary key
        travel_uuid as TravelUuid, //foreign key ke tabel Travel
        booking_id as BookingId, 
    booking_date as BookingDate,
    customer_id as CustomerId,
    carrier_id as CarrierId,
    connection_id as ConnectionId,
    flight_date as FlightDate,
    @Semantics.amount.currencyCode: 'CurrencyCode' //Menandakan bahwa FlightPrice memiliki mata uang yang didefinisikan oleh CurrencyCode.
    flight_price as FlightPrice,
    currency_code as CurrencyCode,
    @Semantics.user.createdBy: true //menyimpan user ID
    created_by as CreatedBy,
    @Semantics.user.lastChangedBy: true //menyimpan user ID yang terakhir mengubah data
    last_changed_by as LastChangedBy,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true //menyimpan tanggal & waktu terakhir kali data diperbarui.
    local_las_changed_at as LocalLasChangedAt,
    
    //Menampilkan Data dari Association
    /* associations */
    _Travel,
    _Customer,
    _Carrier,
    _Connection,
    _Flight,
    _Currency
    

}
