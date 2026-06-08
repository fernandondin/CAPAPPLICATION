using {com.logaligroup as entities} from '../db/schema';

service HeaderService{
    entity Header as projection on entities.Header;
    entity Items as projection on entities.Item;
    @readonly
    entity Status           as projection on entities.Status;
};