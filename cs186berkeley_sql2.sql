-- use sql_practice;

/*
a join query is similar to a single table query, but the from clause can take a list of tables instead of a single table
this table list can be understood as a single relation/table which has the cross (cartesian) product of the list of tables

a cross product can be understood as a concatenation of each each row from each table to produce a single output row, so
if we have 2 tables, table a and table b,
table a
arow0
arow1

table b
brow0
brow1
brow2

let's say the cross product of these 2 tables produces table c, that would be,
table c
arow0 brow0
arow0 brow1
arow0 brow2
arow1 brow0
arow1 brow1
arow1 brow2

each row in the output table is a concatenation of the rows of both tables
*/
-- select
-- 	*
-- from
-- 	Sailors, Boats
-- ;

-- -- getting reservations for a Sailor
select
	Sailors.sid,
    sname,
    rating,
    bid,
    day
from
	Sailors, Reserves
where
	Sailors.sid = Reserves.sid
;
/*
note that we needed to write Sailors.sid in the select clause since it was ambiguous coz was present in both Sailors
and Reserves tables, the other column names were non-ambiguous and we don't need to qualify them with the table name
*/


