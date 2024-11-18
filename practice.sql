-- all these statements can be used to get information about a table
-- desc `Sailors`;
-- describe `Sailors`;
-- explain `Sailors`;
-- show columns from `Sailors`;
-- select * from `Sailors`;

/*
insert into allows insertions to a table in an unordered manner:
the values should correspond to column names mentioned, i.e, should be of the correct data type for the corresponding
column; if any column is omitted, either the default value or null is inserted for that column; if the column is a
primary key, it can't be null and therfore should have a default value or a constraint set up for the column to be
non-null
*/
-- insert into
--     `Sailors` (sname, rating, sid)
-- values ('test0', 3, 8),
--     ('test1', 3, 9),
--     ('test2', 3, 10);

/*
insert into allows insertions from a select clause;
say we have a table `Sailors_test` which has the same columns as `Sailors`:
*/
-- create table `Sailors_test` (
--     sid integer primary key,
--     sname char(20),
--     rating integer,
--     age float
-- );

-- insert into
--     `Sailors_test`
-- values (11, 'cr7', 9, 39),
--     (12, 'lm10', 9, 37);

-- select * from `Sailors_test`;

-- -- we can insert data from `Sailors_test` to `Sailors` using insert into and select clause:
-- insert into `Sailors` select * from `Sailors_test`;

/*
note that this doesn't accept duplicate values, for example, pks;
we can also insert into select columns if we wish:
*/
-- insert into
--     `Sailors_test`
-- values (13, 'ballack', 8, 50),
--     (14, 'ozil', 8, 40);

-- insert into
--     `Sailors` (sid, sname, age)
-- select sid, sname, age
-- from `Sailors_test`
-- where
--     sid in (13, 14);

-- select * from `Sailors`;

/*
`delete` statement allows for removing rows from a table;
a `delete` statement without a `where` clause will remove all rows from that table; in case all rows are to be removed,
`truncate` statement is faster;
however, a `truncate` statement can't be used within a transaction whereas a `delete` statement can be used
*/
-- delete from `test`;

-- truncate `test`;

-- -- for removing a complete table or a database from existence, we use a `drop` statement:
-- drop table `test`;

-- here are a few ways to use a `not` clause:
-- select * from `Sailors` where not sname = 'jai';
-- select * from `Sailors` where sname <> 'jai';
-- -- deprecated, not recommended
-- select * from `Sailors` where sname != 'jai';

/*
when using the `limit` clause we can use the `offset` clause to get rows from a certain offset from the result of the
`limit` clause;
*/
-- select * from `Sailors` where rating = 9 limit 3;
-- select * from `Sailors` where rating = 9 limit 3 offset 0;
-- select * from `Sailors` where rating = 9 limit 3 offset 1;

/*
oracle db 12c also offers a `fetch` clause `with ties` clause that helps returns duplicates with `fetch` and `offset`,
this is similar to when we want duplicates in a `limit` clause in mysql, however, mysql doesn't have this
functionality;
for example, the following query returns a single result:
*/
-- select * from `Sailors` where rating = 9 limit 1;
/*
but we know that there are multiple rows where rating is 9, if mysql had a `with ties` clause, we would have gotten 3
rows from the hypothetical query:
*/
-- select * from `Sailors` where rating = 9;
-- select * from `Sailors` where rating = 9 limit 1 with ties; -- won't run in mysql
/*
for reference:
https://www.geeksforgeeks.org/sql-offset-fetch-clause/
https://www.geeksforgeeks.org/sql-ties-clause/
https://dba.stackexchange.com/questions/159928/limit-of-rows-but-with-complete-sets
*/

select age, age / 10 from `Sailors`;