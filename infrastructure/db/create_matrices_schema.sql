drop schema if exists matrices cascade;
create schema matrices;


create table matrices.features (
    features_csv_id		uuid primary key
    , features_start_year       smallint
    , features_end_year		smallint
    , geography                 text
    , features_list		text
    , creation_time             timestamp with time zone
    , comments			text
);
create index features_index on matrices.features using btree (features_list);


create table matrices.labels (
    labels_csv_id		uuid primary key
    , labels_start_year		smallint
    , labels_end_year		smallint
    , geography                 text
    , label_query		text
    , creation_time             timestamp with time zone
    , comments			text
);

