drop schema if exists results cascade;
create schema results;


create table results.predictions(
    entity_id			serial
    , model_id			serial references modeling.models(model_id) on delete cascade
    , labels_start_year		timestamp
    , labels_end_year		timestamp
    , prediction		numeric
    , label			numeric
    , features_csv_name		text
    , labels_csv_name 		text
);


create table results.evaluations(
    model_id			serial references results.predictions(model_id) on delete cascade
    , metric			text
    , parameter1		text
    , parameter2		numeric
    , value			numeric			
);

