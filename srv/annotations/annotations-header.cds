using {HeaderService as myservice} from '../service';
using from './annotations-item';

annotate myservice.Header with @odata.draft.enabled;

annotate myservice.Header with {
    email      @title: 'Email';
    fname      @title: 'First Name';
    lname      @title: 'Last Name';
    country    @title: 'Country';
    createOn   @title: 'Created On';
    deliveryDate @title: 'Delivery Date';
    orderStatus  @title: 'Order Status';
    item         @title: 'Item';
    image        @title: 'Image' @UI.IsImage;   
}



annotate myservice.Header with @(
    UI.SelectionFields:[
        email,
        fname,
        lname,
        country,
        createOn,
        deliveryDate,
        orderStatus
    ],
    UI.HeaderInfo :{
        $Type : 'UI.HeaderInfoType',
        TypeName: 'Sale Order',
        TypeNamePlural: 'Sales Orders',
        Title: {
            $Type : 'UI.DataField',
            Value : fname,
        },
        Description:{
            $Type : 'UI.DataField',
            Value : email,
        }
    },
    UI.LineItem :[
        {
            $Type : 'UI.DataField',
            Value : image,
        },
        {
            $Type : 'UI.DataField',
            Value : email,
        },
        {
            $Type : 'UI.DataField',
            Value : fname,
        },
        {
            $Type : 'UI.DataField',
            Value : lname,
        },
        {
            $Type : 'UI.DataField',
            Value : country,
        },
        {
            $Type : 'UI.DataField',
            Value : createOn,
        },
        {
            $Type : 'UI.DataField',
            Value : deliveryDate,
        },
        {
            $Type : 'UI.DataField',
            Value : orderStatus_code,
            Criticality : orderStatus.criticality,
        },
         
    ],
    UI.FieldGroup #Picture: {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : image,
                Label : '',
            }
        ],
    },
    UI.FieldGroup #Group_HA:{
        $Type: 'UI.FieldGroupType',
        Data: [
            {
                $Type : 'UI.DataField',
                Value : lname,
            },
            {
                $Type : 'UI.DataField',
                Value : country,
            },
        ]
    },
    UI.FieldGroup #Group_HB:{
        $Type: 'UI.FieldGroupType',
        Data: [
            {
                $Type : 'UI.DataField',
                Value : country,
            },
            {
                $Type : 'UI.DataField',
                Value : createOn,
            },
            {
                $Type : 'UI.DataField',
                Value : deliveryDate,
            },
        ]
    },
    UI.FieldGroup #Group_HC:{
        $Type: 'UI.FieldGroupType',
        Data: [
            {
                $Type : 'UI.DataField',
                Value : orderStatus_code,
                Criticality : orderStatus.criticality,
            },
        ]
    },
    UI.HeaderFacets :[
         {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#Picture',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#Group_HA'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#Group_HB'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#Group_HC'
        }
    ],
    UI.Facets :[
        {
            $Type : 'UI.ReferenceFacet',
            Target: 'item/@UI.LineItem#Items',
            Label: 'Items'
        }
    ]

);