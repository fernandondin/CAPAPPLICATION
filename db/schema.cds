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
    deliveryDate    : DateTime;
    orderStatus     : Association to Status;
    item            : Composition of many Item on item.header = $self; //item_id
    image           : LargeBinary @Core.MediaType: imageType  @Core.ContentDisposition.Filename: fileName;
    imageType       : String       @Core.IsMediaType;
    fileName        : String;
}

entity Item : cuid{
    name   : String(40);
    description : String(40);
    releaseDate : DateTime;
    discontinuedDate: DateTime;
    price           : Decimal(12,2);
    currency      : Association to Currencies default 'USD';
    header          : Association to Header;
}

entity Status : CodeList {
    key code        : String(20) enum {
            created = 'Created';
            released = 'Released';
            locked = 'Locked';
        };
        criticality : Int16;
};


entity Options : CodeList {
    key code : String(10) enum {
            C = 'Create';
            R = 'Release';
            L = 'Lock'
        };
}