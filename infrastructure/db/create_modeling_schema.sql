drop schema if exists modeling;
create schema modeling;


create table modeling.model_groups (
    model_group_id 		serial primary key
    , model_parameters		json
);


create table modeling.models (
    model_id 			serial primary key
    , model_group_id 		serial references modeling.model_groups(model_group_id) on delete cascade
    , features_start_year 	timestamp 
    , features_end_year 	timestamp
    , labels_start_year 	timestamp
    , labels_end_year 		timestamp
    , features_csv_name 	text
    , labels_csv_name 		text
);


