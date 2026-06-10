using {HeaderService as myservice} from '../service';

annotate myservice.Options with{
    code @title : 'Options'
};

annotate myservice.dialog with{
    myOption @title : 'Option';
}

annotate myservice.dialog with{
    myOption @Common :{
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Options',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : myOption,
                    ValueListProperty : 'code'
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name'
                }
            ]
        }
    }
}