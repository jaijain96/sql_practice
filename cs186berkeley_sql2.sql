-- use sql_practice;

/*
a join query is similar to a single table query, but the from clause can take 
a list of tables instead of a single table, this table list can be understood 
as a single relation/table which has the cross (cartesian) product of the list 
of tables
a cross product can be understood as a concatenation of each each row from 
each table to produce a single output row, so if we have 2 tables, table a 
and table b:
*/

/*
table a:
arow0
arow1
*/

/*
table b:
brow0
brow1
brow2
*/

/*
the cross product of these 2 tables produces table c, that would be:
*/
/*
table c:
arow0 brow0
arow0 brow1
arow0 brow2
arow1 brow0
arow1 brow1
arow1 brow2
*/
/*
each row in the output table is a concatenation of the rows of both tables
*/
-- select * from Sailors, Boats;

-- -- getting reservations for a Sailor
-- select Sailors.sid, sname, rating, bid, day
-- from Sailors, Reserves
-- where
--     Sailors.sid = Reserves.sid;
/*
note that we needed to write Sailors.sid in the select clause since it was 
ambiguous coz was present in both Sailors and Reserves tables, the other 
column names were non-ambiguous and we don't need to qualify them with the 
table name
*/

/*
we can also have self joins, which can be used in situations where we need to 
compare to rows of the same table with each other
*/
-- select * from `Sailors` x, `Sailors` y;

/*
say we want to find pair of Sailors where the left Sailor's age is less than 
the right Sailors age, we can do it in this manner:
*/
select x.sname, x.age, y.sname, y.age
from `Sailors` x, `Sailors` y
where
    x.age < y.age;

/*
what if we wanted the opposite, pairs where the right Sailor's age is less 
than the left Sailor's age, we can do it this way:
*/
select x.sname, x.age, y.sname, y.age
from `Sailors` x, `Sailors` y
where
    y.age < x.age;
/*
or simply:
*/
select x.sname, x.age, y.sname, y.age
from `Sailors` x, `Sailors` y
where
    x.age > y.age;

/*
we can have arithmetic expressions within the select clause
here, we get the rating % for the Sailors table, on the assumption that each 
rating had been awarded out of a max rating of 10
*/
select rating, (rating / 10) * 100 from `Sailors`;

/*
here we calculate the normalized rating for each Sailor, how do we do this in 
a single query?
*/
-- select max(rating) - min(rating) from `Sailors`;
-- select min(rating) from `Sailors`;
select rating, ((rating - 2) / 7) from `Sailors`;

/*
we can use arithmetic expressions in the where clause
*/
select age from `Sailors` where age * 2 < 50;

/*
we can use sql as a calculator
*/
select (53 + 21 + 35 + 47 + 58) / 9;

/*
sql also supports string functions, particularly string comparison functions,
we can have a regex match using the like keyword (which is old school sql 
and doesn't support the regex patterns we know in from most modern 
programming languages):
*/
select sname from `Sailors` where sname like 'j_%';

/*
or we can have a regex match using the ~ operator (which is the modern regex
match operator and supports regex patterns like we know from modern unix tools 
and programming languages):
*/
select sname from `Sailors` where sname REGEXP('j.*');

/*
we should be careful when combining predicates in the where clause since there 
are subtle connections between using boolean logic (and, or ) in the where 
clause and traditional set operations (intersect, union)
*/

/*
let's make a few changes to our boats and reserves tabes:
*/
insert into
    `Boats`
values (104, 'titanic', 'green'),
    (105, 'high lander', 'green');

update `Reserves` set bid = 102 where sid = 2;

insert into
    `Reserves`
values (3, 104, date('2015-10-2')),
    (4, 104, date('2017-10-5')),
    (4, 101, date('2017-10-5')),
    (4, 103, date('2017-10-7')),
    (4, 105, date('2017-10-7'));

/*
at this point the boats table looks like this:
+-------+---------------+----------+
| 'bid' |    'bname'    |  'color' |
+-------+---------------+----------+
| '101' | 'Nina'        | 'red'    |
| '102' | 'Pinta'       | 'blue'   |
| '103' | 'Santa Maria' | 'red'    |
| '104' | 'titanic'     | 'green'  |
| '105' | 'high lander' | 'green'  |
+-------+---------------+----------+
*/
/*
and the reserves table looks like this:
+-------+-------+--------------+
| 'sid' | 'bid' |    'day'     |
+-------+-------+--------------+
| '1'   | '101' | '2015-09-12' |
| '4'   | '101' | '2017-10-05' |
| '2'   | '102' | '2015-09-13' |
| '4'   | '103' | '2017-10-07' |
| '3'   | '104' | '2015-10-02' |
| '4'   | '104' | '2017-10-05' |
| '4'   | '105' | '2017-10-07' |
+-------+-------+--------------+
*/

/*
we need to request the sid (Sailor id), i.e, Sailors who have reserved boats 
that have a 'red' or a 'green' color; we can achieve this by the following 
query:
*/
select sid
from `Boats` b, `Reserves` r
where
    b.bid = r.bid
    and (
        b.color = 'red'
        or b.color = 'green'
    );

/*
the same can be achieved by using the union clause; when we do a union, we 
mean -> take the output tuples from the first query and the output tuples 
from the second query
*/
select sid
from `Boats` b, `Reserves` r
WHERE
    b.bid = r.bid
    and b.color = 'red'
UNION
select sid
from `Boats` b, `Reserves` r
WHERE
    b.bid = r.bid
    and b.color = 'green';
/*
by default, union clause does a dedupe on the output tuples, to prevent this 
behaviour, we can use the union all clause:
*/
select sid
from `Boats` b, `Reserves` r
WHERE
    b.bid = r.bid
    and b.color = 'red'
UNION ALL
select sid
from `Boats` b, `Reserves` r
WHERE
    b.bid = r.bid
    and b.color = 'green';

/*
let's say we have another situation, where we need to request the 
sid (Sailor id), i.e, Sailors who have reserved 'red' colored and 'green' 
colored boats; we might be tempted to write a query for it in this manner:
*/
select sid
from `Boats` b, `Reserves` r
where
    b.bid = r.bid
    and (
        b.color = 'red'
        and b.color = 'green'
    );
/*
but this query returns no sids, but we know that the 'jai' Sailor with sid 4 
had made 2 reservations, one of the 'red' boat 'Nina' and the other of the 
'green' boat 'titanic', he has also made 2 other reservations for another pair 
of 'red' and 'green' boats, 'Santa Maria' and 'high lander' respectively;
how do we write a query for this?
the answer lies is in finding the error in the query above; in the query 
above, we are asking for all sids where the color of the boat is both 'red' 
and 'green' -> which is non-sensical, there can't be a boat of both 'red' and 
'green' color, what we need is to find sids of boat reservations where the 
color of the boat is 'red', we then find sids of boat reservatons where the 
color of the boat is 'green' and then we take the common sids from both 
outputs, i.e, an intersection, we can write a query for this in this manner:
*/
select sid
from `Boats` b, `Reserves` r
where (
        b.bid = r.bid
        and b.color = 'red'
    ) INTERSECT
select sid
from `Boats` b, `Reserves` r
where (
        b.bid = r.bid
        and b.color = 'green'
    );
/*
this gives us the sid 4 corresponding to Sailor 'jai', as was the case with 
union, by default, the intersection clause also does a dedupe on the output 
tuples, to prevent this behaviour, we can use the intersect all clause:
*/
select sid
from `Boats` b, `Reserves` r
where (
        b.bid = r.bid
        and b.color = 'red'
    ) INTERSECT ALL
select sid
from `Boats` b, `Reserves` r
where (
        b.bid = r.bid
        and b.color = 'green'
    );
/*
this gives us the 2 instances of sid '4' (Sailor 'jai') who made 4 
reservations:
'Nina': 'red'
'titanic': 'green'
'Santa Maria': 'red'
'high lander': 'green'
taken in combinations, the following 'red', 'green' pairs can be formed:
'Nina':'red', 'titanic':'green'
'Santa Maria': 'red', 'high lander': 'green'
or
'Nina':'red', 'high lander': 'green'
'Santa Maria': 'red', 'titanic':'green'
so for any combination, there are only 2 such pairs where a Sailor has made 
reservations for 'red' boat and a 'green' boat, not a boat which is both 
'red' and 'green' in color.
*/
