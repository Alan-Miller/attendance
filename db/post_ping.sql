insert INTO ping_data(user_id, ping, pingtz)
values ($1, now(), now());

select * from ping_data;