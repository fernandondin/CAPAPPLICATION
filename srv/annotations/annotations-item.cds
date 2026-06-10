using {HeaderService as myservice} from '../service';

annotate myservice.Item with{
    name @title: 'Item Name'; 
    description @title: 'Item Description';
    releaseDate @title: 'Release Date';
    discontinuedDate @title: 'Discontinued Date';
    price @title: 'Price' @Measures.ISOCurrency: currency_code;
    header @title: 'Header';
    currency    @title: 'Currency'  @Common.IsCurrency;
}

annotate myservice.Item with @(
     UI.HeaderInfo : {
        TypeName : 'Review',
        TypeNamePlural : 'Reviews',
        Title : {
            $Type : 'UI.DataField',
            Value : name
        },
        Description:{
            $Type : 'UI.DataField',
            Value : description,
        }
    },
    UI.LineItem #Items:[
        
        {
            $Type : 'UI.DataField',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Value : description,
        },
        {
            $Type : 'UI.DataField',
            Value : releaseDate,
        },
        {
            $Type : 'UI.DataField',
            Value : discontinuedDate,
        },
        {
            $Type : 'UI.DataField',
            Value : price,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'Item.setStatus',
            Label: 'Set Status',
            Inline : true,
        },
    ],
    UI.FieldGroup #ItemsInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
            $Type : 'UI.DataField',
            Value : releaseDate,
            },
            {
                $Type : 'UI.DataField',
                Value : discontinuedDate,
            },
            {
                $Type : 'UI.DataField',
                Value : price,
            },
        ],        
    },
    UI.Facets  : [
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#ItemsInformation',
            Label : 'Information'
        }
    ],
);