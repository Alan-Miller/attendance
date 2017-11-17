DO
$punch$
declare
    users json = $1;
    users_len int = json_array_length(users);
begin

for i in 0..users_len - 1
loop
    insert into time_punches (username, here, date_time) 
    select users->i->>'username', cast(users->i->>'here' as boolean), users->i->>'date_time'
        where cast(users->i->>'here' as boolean) = true
        and not exists (
            select distinct on (username) * from time_punches where username = users->i->>'username' order by username, id desc
        );
    
    insert into time_punches (username, here, date_time) 
    select users->i->>'username', cast(users->i->>'here' as boolean), users->i->>'date_time'
        where cast(users->i->>'here' as boolean) <> (
            select distinct on (username) here from time_punches where username = users->i->>'username' order by username, id desc
        );
end loop;

end;
$punch$;

-- delete from time_punches;
select * from time_punches order by id desc;