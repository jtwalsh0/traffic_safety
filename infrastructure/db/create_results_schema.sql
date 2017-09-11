drop schema if exists results cascade;
create schema results;


create table results.predictions(
    entity_id			serial
    , model_id			serial references modeling.models(model_id) on delete cascade
    , prediction		numeric
    , label			numeric
    , test_set_features_csv_id	uuid references matrices.features(features_csv_id) on delete cascade
    , test_set_labels_csv_id 	uuid references matrices.labels(labels_csv_id) on delete cascade
);


create table results.evaluations(
    model_id			serial 
    , metric			text
    , parameter1		text
    , parameter2		numeric
    , value			numeric
    , features_csv_id           uuid
    , labels_csv_id		uuid
);


