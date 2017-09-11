drop schema if exists matrices cascade;
create schema matrices;


create table matrices.features (
    features_csv_id		uuid primary key
    , features_start_year       timestamp
    , features_end_year		timestamp
    , features_list		json
    , comments			text
);


create table matrices.labels (
    labels_csv_id		uuid primary key
    , labels_start_year		timestamp
    , labels_end_year		timestamp
    , label_query		text
    , comments			text
);

