drop schema if exists matrices cascade;
create schema matrices;


create table matrices.features (
    features_csv_id		uuid primary key
    , features_start_year       smallint
    , features_end_year		smallint
    , features_list		text
    , comments			text
);


create table matrices.labels (
    labels_csv_id		uuid primary key
    , labels_start_year		smallint
    , labels_end_year		smallint
    , label_query		text
    , comments			text
);

