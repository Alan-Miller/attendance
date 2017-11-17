DO
$test$
declare
peeps json = '[{"ident": "Brennon Schow", "here": true}, {"ident": "Brock Pettyjohn", "here": true}, {"ident": "Emily Keator", "here": true}]';
peeps_len int = json_array_length(peeps);
begin

for i in 0..peeps_len - 1
loop
    insert into pings (username, here) 
    select peeps->i->>'ident', cast(peeps->i->>'here' as boolean)
        where cast(peeps->i->>'here' as boolean) = true
        and not exists (
            select distinct on (username) * from pings where username = peeps->i->>'ident' order by username, id desc
        );
    
    insert into pings (username, here) 
    select peeps->i->>'ident', cast(peeps->i->>'here' as boolean)
        where cast(peeps->i->>'here' as boolean) <> (
            select distinct on (username) here from pings where username = peeps->i->>'ident' order by username, id desc
        );
end loop;

end;
$test$;

-- select distinct on (username) here from pings where username = 'Emily Keator' order by username, id desc;
-- delete from pings;
select * from pings order by id desc;