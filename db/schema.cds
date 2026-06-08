namespace com.logaligroup;
using {
    cuid,
    managed,
    sap.common.CodeList,
    sap.common.Currencies
} from '@sap/cds/common';

entity Header : cuid, managed{
    email    : String(30);
    fname    : String(30);
    lname    : String(30);
    country  : String(30);
    createOn : DateTime;
    deliveryDate : DateTime;
    orderStatus : Association to Status;
    item     : Association to Item; //item_id
    image : LargeBinary @Core.MediaType: imageType  @Core.ContentDisposition.Filename: fileName;
    imageType     : String       @Core.IsMediaType;
    fileName      : String;
}

entity Item : cuid{
    name   : String(40);
    description : String(40);
    releaseDate : DateTime;
    discontinuedDate: DateTime;
    price           : Decimal(12,2)
}

entity Status : CodeList {
    key code        : String(20) enum {
            created = 'Created';
            released = 'Released';
            locked = 'Locked';
        };
        criricality : Int16;
};