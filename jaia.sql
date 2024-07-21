/*
create table test (y int);

drop PROCEDURE test_proc;

create PROCEDURE test_proc()
begin
    DECLARE x INT DEFAULT 0;
        label1: loop insert into test values (x);
        set x = x + 1;
        if x > 10 then leave label1;
        end if;
    end loop;
end

call test_proc ();

begin
select * FROM (
    DECLARE x INT DEFAULT 0;
        label1: loop
            -- insert into test values (x);
            -- SELECT x;
            set x = x + 1;
            if x > 10 then leave label1;
            end if;
        end loop;
    )
end;
*/