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
is the above logic correct for understanding the nature of intersect all?
need more examples/questions
*/

/*
nested queries or subqueries with the `in` clause;
here we are getting all Sailor names who made a reservation for boat 101
*/
select s.sname
from `Sailors` s
where
    s.sid in (
        select r.sid
        from `Reserves` r
        where
            r.bid = 101
    );

/*
we can use `not in` for getting the opposite result,
we can search for all Sailor names who didn't make a reservation for boat 101
*/
select s.sname
from `Sailors` s
where
    s.sid not in(
        select r.sid
        from `Reserves` r
        where
            r.bid = 101
    );

/*
we can use the `exists` clause for filtering based on row existence,
the query below will give all Sailor names if any reservation for bid 101 had
been made, else will return nothing
*/
select s.sname
from `Sailors` s
where
    exists (
        select r.sid
        from `Reserves` r
        where
            r.bid = 101
    );

/*
the query below is an example of a correlated subquery, which means that there 
is a reference to a object 's' of the outer query, within the subquery;
a correlated subquery can be though of as a function equivalent in a 
programming language, the subquery will be executed for each tuple processed 
from the outer query, in the case below, each tuple from Sailors table will be 
passed to the subquery and then the subquery will be run for that tuple, if a 
result is returned for that subquery, the outer query's where clause treats 
that as true because of the exists clause and that tuple (that was passed 
from the outer query to the subquery) is kept in the output
*/
select s.sname
from `Sailors` s
where
    exists (
        select *
        from `Reserves` r
        where
            r.bid = 102
            and r.sid = s.sid
    );

/*
apart from the `in`, `not in`, 'exists`, `not exists`, there are other query 
comparators, `any` and `all`;
we can use `any` in this manner: 
*/
select s.sname
from `Sailors` s
where
    s.rating < any (
        select s2.rating
        from `Sailors` s2
        where
            s2.sname = 'jai'
    );

/*
need more practice of any and all
*/

/*
how do we find the argmax for a particular column for a table,
let's say we want to find the Sailor with the maximum rating, one way to do so 
is with the following query:
*/
select sname
from `Sailors`
where
    rating = (
        select max(rating)
        from `Sailors`
    );

/*
another way to do so is this way:
*/
select sname
from `Sailors`
where
    rating >= all (
        select rating
        from `Sailors`
    );

/*
or maybe we do this way:
*/
select sname from `Sailors` order by rating desc limit 1;

/*
the difference between the last query and the 2 before that for calculating 
the argmax is that the last one is a little non-deterministic; in case there 
is more that one tuple that is the argmax, the last query can give different 
results, whereas, the first 2 queries will always return the set of all rows 
that are all argmax for the set
*/

/*
a general join statement can have the following structure:
```
select <column expression list>
from table_name
[inner|natural|cross|{left | right | full}{outer}] join
table_name
on <qualification list>
where
...
```
we read the `from` clause expression: 
`[inner|natural|cross|{left | right | full}{outer}] join`
in this manner:
the `|` character is what it is in most programming langauages, stands for 
'or', whereas, the `{}` denote optional values, this means, the valid values 
from the above expression are:
join
inner join
natural join
cross join
since the outer keyword is optional, these are equivalent:
left join <-> left outer join
right join <-> right outer join
full join <-> full outer join
*/

/*
the syntax that we have been using for joins:
*/
select * from `Sailors` s, `Reserves` r;
/*
is equivalent to an explicit cross join:
*/
select * from `Sailors` s cross join `Reserves` r;

/*
also, `inner join` and `join` are equivalent:
*/
select * from `Sailors` s inner join `Reserves` r;
/*
although mysql allows this, an inner join without a `on` clause isn't allowed 
in standard sql
*/

select * from `Sailors` s join `Reserves` r;
/*
although mysql allows this, a join without a `on` clause isn't allowed in 
standard sql
*/

/*
in mysql, inner join and cross join are equivalent, but not in standard sql;
in standard sql, an inner join (or simply join) must have a `on` clause, 
whereas, a cross join (or an implicit join, i.e, without the `join` keyword) 
can't have a `on` clause;
mysql allows all 4 cases:
implicit join
cross join
inner join
join
to be equivalent, i.e, they can all have the `on` clause except the implicit 
join, the following are equivalent:
*/
select * from `Sailors` s, `Reserves` r where s.sid = r.sid;
/*
coz we can't have a `on` clause in an implicit join
*/

select * from `Sailors` s cross join `Reserves` r on s.sid = r.sid;
/*
although mysql allows this, a cross join with a `on` clause isn't allowed in 
standard sql
*/

select * from `Sailors` s inner join `Reserves` r on s.sid = r.sid;

select * from `Sailors` s join `Reserves` r on s.sid = r.sid;

/*
there is another flavour of inner join, called the natural join, a natural 
join is the same as inner join, but doesn't take in a `on` clause, this is 
because by default, the natural join takes any columns that are common to the 
tables we are joining and performs inner join using those columns
*/
select * from `Sailors` s natural join `Reserves` r;

/*
in the inner join, only rows that have the same values for `on` clause 
'qualification list' are kept in the output, the left join simply preserves 
unmatched rows from the left table in the output, but not from the right 
table; for unmatched rows, the output column values from the right table are 
simply nulls
*/
select *
from `Sailors` s
    left join `Reserves` r on s.sid = r.sid;

/*
similarly, the right join preserves unmatched rows from the right table in the 
output, but not from the left table; for unmatched rows, the output column 
values from the left table are simply nulls
*/
select *
from `Sailors` s
    right join `Reserves` r on s.sid = r.sid;

/*
the full join preserves unmatched rows from both the left table and right 
table in the output; for unmatched rows, the output column values from both 
tables are simply nulls
*/
select *
from `Sailors` s
    right join `Reserves` r on s.sid = r.sid;

/*
views are named queries, can be treated as macros or functions in a 
programming language; they make development easier and are often used for 
providing security by enhancing access control,
an example of this is a simple case where we want to give a subset of our 
users access to a table's data, but we don't want to give access to all 
columns of that table, in this scenario, we can create a view on that table 
which contains only that column and we give our users access to that view 
instead of that table;
views are not materialized, which means that they don't store any data, they 
are simply stored queries which upon execution will return the data queried, 
if the underlying tables that a view is querying changes, the results of 
querying the view will also change
*/

create view redcount as (
    select b.bid, count(*) as scount
    from `Boats` b, `Reserves` r
    where
        r.bid = b.bid
        and b.color = 'red'
    group by
        b.bid
);

/*
post creation, views can be used similar to regular tables in a query
*/
select * from redcount;

/*
views can be created on the fly by adding the "view" query in the from clause 
followed by the as clause
*/
select bname, scount
from `Boats` b, (
        select b.bid, count(*)
        from `Boats` b, `Reserves` r
        where
            r.bid = b.bid
            and b.color = 'red'
        group by
            b.bid
    ) as reds (bid, scount)
where
    reds.bid = b.bid
    and scount < 10;
/*
something to note is that when we mention the paranthesized subquery in the 
from clause, there is a comma (`,`) that separates the tables, hence we are 
doing an implicit join (cross join) with the view/table returned by the 
subquery;
the same query be written in a more structured form in this manner:
*/
with
    reds (bid, scount) as (
        select b.bid, count(*)
        from `Boats` b, `Reserves` r
        where
            r.bid = b.bid
            and b.color = 'red'
        group by
            b.bid
    )
select bname, scount
from `Boats` b, reds
where
    reds.bid = b.bid
    and scount < 10;
/*
this way of defining a view subquery using the `with` statement is called a 
common table expression (cte); again, note that we are joining the table/view 
returned by 'reds' cte with the 'Boats' table in the from clause;
we can have many queries in the with or the cte:
*/
with
    reds (bid, scount) as (
        select b.bid, count(*)
        from `Boats` b, `Reserves` r
        where
            r.bid = b.bid
            and b.color = 'red'
        group by
            b.bid
    ),
    unpopularreds as (
        select bname, scount
        from `Boats` b, reds
        where
            reds.bid = b.bid
            and scount < 10
    )
select *
from unpopularreds;

select sname, age, rating from `Sailors`;

insert into `Sailors` values (7, 'drew', 7, 45);

update `Sailors` set sname = 'pam' where sname = 'hello';

update `Sailors` set rating = 7 where sname = 'pam';

/*
argmax rating for each age group:
*/
-- with
--     age_group_max_rating (group_age, max_rating) as (
--         select age as group_age, max(rating) as max_rating
--         from `Sailors`
--         group by
--             age
--     )
-- select s.sname, s.age, s.rating
-- from
--     `Sailors` as s,
--     age_group_max_rating as m
-- where
--     s.rating = m.max_rating and s.age = m.group_age;

with
    age_group_max_rating (max_rating) as (
        select max(rating) as max_rating
        from `Sailors`
        group by
            age
    )
select distinct
    s.sname,
    s.age,
    s.rating
    -- , m.max_rating
from
    `Sailors` as s,
    age_group_max_rating as m
where
    s.rating = m.max_rating;

select sname, age, rating from `Sailors`;

select max(rating) as max_rating from `Sailors` group by age;