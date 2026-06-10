using {com.logaligroup as entities} from '../db/schema';

service HeaderService{

    type dialog {
        myOption : String(10);
    };

    entity Header as projection on entities.Header;
    entity Item as projection on entities.Item actions {
         @Core.OperationAvailable: {
            $edmJson: {
                $If:[
                    {
                        $Eq:[
                            {
                                $Path: 'in/header/IsActiveEntity'
                            },
                            false
                        ]
                    },
                    false,
                    true
                ]
            }
        }
        @Common: {
            SideEffects: {
                $Type: 'Common.SideEffectsType',
                TargetProperties: [
                    'in/releaseDate'
                ],
                TargetEntities:[
                    in.header
                ]
            }
        }
        action setStatus(
            in: $self,
            option: dialog:myOption,
        )
    };
    @readonly
    entity Status           as projection on entities.Status;

    @readonly
    entity Options as projection on entities.Options;
};