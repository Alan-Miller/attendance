insert into users (username, mac_address, cohort)
select $1, $2, $3
where not exists (
    select mac_address from users
    where mac_address = $2
);


select * from users order by id;