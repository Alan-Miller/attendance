create table time_punches (
    id serial primary key,
    username varchar(80),
    here boolean,
    date_time varchar(50)
);