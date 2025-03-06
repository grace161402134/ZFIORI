@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Booking Data'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZC_RAP_GRC_BOOK_U_1234 as projection on ZI_RAP_GRC_BOOK_U_1234
{
    @Search.defaultSearchElement: true
    key TravelID,
    @Search.defaultSearchElement: true
    key BookingID,
    BookingDate,
    @Consumption.valueHelpDefinition: [ { entity: { name:     '/DMO/I_Customer',
                                                      element:     'CustomerID' } } ]
    CustomerID,
     @Consumption.valueHelpDefinition: [ { entity: { name:     '/DMO/I_Carrier',
                                                 element:     'AirlineID' } } ]
    CarrierID,
     @Consumption.valueHelpDefinition: [ { entity: { name:    '/DMO/I_Flight',
                                                   element: 'ConnectionID' },
                                         additionalBinding: [ { localElement: 'FlightDate',
                                                                element:      'FlightDate',
                                                                usage: #RESULT }, 
                                                              { localElement: 'CarrierID',
                                                                     element: 'AirlineID',
                                                                       usage: #RESULT }, 
                                                              { localElement: 'FlightPrice',
                                                                     element: 'Price',
                                                                       usage: #RESULT }, 
                                                              { localElement: 'CurrencyCode',
                                                                     element: 'CurrencyCode',
                                                                       usage: #RESULT } ] 
                                         } ]
    ConnectionID,
    FlightDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    FlightPrice,
      @Consumption.valueHelpDefinition: [ {entity: { name:    'I_Currency',
                                                    element: 'Currency' } } ]
    CurrencyCode,
    /* Associations */
    _Carrier,
    _Connection,
    _Customer,
    _Flight,
    _Travel : redirected to parent ZC_RAP_GRC_TRAVEL_U_1234
}
