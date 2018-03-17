DO
$punch$
declare
    users json = $1;
    users_len int = json_array_length(users);
BEGIN

for i in 0..users_len - 1
LOOP
    -- add row if user is here for the first time
    INSERT INTO time_punches (username, here, date_time) 
    SELECT users->i->>'username', CAST(users->i->>'here' AS BOOLEAN), users->i->>'date_time'
        WHERE CAST(users->i->>'here' AS BOOLEAN) = true
        AND NOT EXISTS (
            SELECT DISTINCT ON (username) * FROM time_punches WHERE username = users->i->>'username' ORDER BY username, id DESC
        );
    
    -- add row if passed-in here value is different from last time's here value
    INSERT INTO time_punches (username, here, date_time) 
    SELECT users->i->>'username', CAST(users->i->>'here' AS BOOLEAN), users->i->>'date_time'
        WHERE CAST(users->i->>'here' AS BOOLEAN) <> (
            SELECT DISTINCT ON (username) here FROM time_punches WHERE username = users->i->>'username' ORDER BY username, id DESC
        );
END LOOP;

END;
$punch$;

SELECT * FROM time_punches ORDER BY id DESC;