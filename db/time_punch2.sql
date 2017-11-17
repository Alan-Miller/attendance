DO
$BODY$
declare
    people json := $1;
    array_len int = array_upper(people, 1);
    ident text := 'ident';
    here text := 'here';
begin
    -- for i in select * from json_each_text(people)
    for i in 1..array_len
        -- select people->>
    loop
        insert into pings (username, here) 
        select people[i]->>ident, people[i]->>here;
    end loop;
end;
$BODY$;

select * from pings;



-- DO
-- $BODY$
-- declare
--     -- people json := '{"Joe Blank": true, "Brack Carmony": true, "Brennon Schow": true, "Megan Fisher": false, "Beth Telford": true, "Mason Galland": false, "Doug Maxfield": true, "Brock Pettyjohn": true, "Emily Keator": true}';
--     -- people varchar[][] = '{{"Joe Blank", true}, {"Emily Keator", true}}';
--     -- people json := $1;
--     people json = $1;
--     -- i varchar[];
--     array_len int = array_upper(people, 1);
--     ident text := 'ident';
--     here text := 'here';
-- begin
--     -- for i in select * from json_each_text(people)
--     for i in 1..array_len
--         -- select people->>
--     loop
--         insert into pings (username, here) 
--         select people[i]->>ident, people[i]->>here;
--     end loop;
-- end;
-- $BODY$;

-- select * from pings;