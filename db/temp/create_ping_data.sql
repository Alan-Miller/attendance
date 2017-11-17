create table ping_data(
    id serial primary key,
    user_id integer references users.id,
    ping timestamp
)