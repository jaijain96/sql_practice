-- create database sql_practice;

-- use sql_practice;

-- create table Sailors (  sid integer,     sname char(20),     rating integer,     age float);

-- -- can add primary key later as well
-- alter table Sailors add primary key (sid);

-- create table Boats (  bid integer,     bname char(20),     primary key (bid) );

-- create table Reserves (
-- 	sid integer,
--     bid integer,
--     day date,
--     primary key (sid, bid, day),
-- -- need to specify the reference to key in other table, i.e, the following line can't be: 'foreign key (sid) references Sailors',
--     foreign key (sid) references Sailors (sid),
--     foreign key (bid) references Boats (bid)
-- );

-- insert into Sailors values
-- (1, 'Fred', 7, 22),
-- (2, 'Jim', 2, 39),
-- (3, 'Nancy', 8, 27)
-- ;

-- select * from Sailors;

-- alter table Boats add column color char(20);

-- insert into Boats values
-- (101, 'Nina', 'red'),
-- (102, 'Pinta', 'blue'),
-- (103, 'Santa Maria', 'red')
-- ;

-- select * from Boats;

-- -- always specify date in year-month-date format
-- insert into Reserves values
-- (1, 102, date('2015-9-12')),
-- (2, 102, date('2015-9-13'))
-- ;

-- select * from Reserves;

/*
select distinct returns all the distinct (col0, col1, ... coln-1) tuples, i.e, the distinct is not just on the
column name against which you specify it, but over all the columns that follow
the following query returns all distinct sid, bid pairs from the 'Reserves' table
*/
-- select distinct
-- 	sid,
-- 	bid
-- from
-- 	Reserves;

/*
in an order by clause, we first do the ordering on the first column that's specified, if there is a tie on the first column that we
specify, we break the tie by ordering on the next column and so on
order by has to be on columns mentioned in the select clause, coz that's what we are sorting
*/
-- select
-- 	*
-- from
-- 	Sailors
-- order by
-- 	age,
--     rating
-- ;

/*
each aggregate clause will produce a single row of output for each group
here we haven't specified any group, so the group is the whole table
*/
-- select
-- 	avg(rating)
-- from
-- 	Sailors
-- ;

-- insert into
-- 	Sailors
-- values
-- 	(4, 'jai', 9, 27)
-- ;

/*
the following query is an error, coz the 'avg' aggregate clause returns a single value for a group, since we haven't specified it,
the group is the whole table, the error here is that how does sql know to return a single value of age for the whole group, i.e,
what value to chose in the age column for the whole table, therefore, this query is an error
*/
-- select
-- 	age, avg(rating)
-- from
-- 	Sailors;

/*
following the previous query, we need to make sure to get a single value for the age column, we can use an aggregate function
for doing this, or we can group by on the age column, which would create groups from the whole table based on age column, i.e,
it will return a single value for each group and then aggregate over each group's rating,
cardinality of output = number of distinct group values
*/
-- select
-- 	age,
--     avg(rating)
-- from
-- 	Sailors
-- group by
-- 	age
-- ;

-- insert into
-- 	Sailors
-- values
-- 	(5, 'hello', 8, 27)
-- ;

/*
in the following query, we do group by S.age, which implies, create groups based on S.age, i.e, for each unique age in the
age column, output only a single row, the corresponding values of all columns for that row have to be aggregated or ommitted or
further grouped by, because for a group, we need to tell sql how to output a single value for all the grouped rows, for every
column that we want in the output (that exists in the select statement), therefore the columns that we mention in the select
statement are dependent on the columns we are grouping by
*/
-- select
-- 	S.age
-- from
-- 	Sailors S
-- group by
-- 	S.age
-- ;

/*
at this point, the Sailors table looks like this:
+=====+=======+========+=====+
| sid | sname | rating | age |
+=====+=======+========+=====+
|   1 | Fred  |      7 |  22 |
+-----+-------+--------+-----+
|   2 | Jim   |      2 |  39 |
+-----+-------+--------+-----+
|   3 | Nancy |      8 |  27 |
+-----+-------+--------+-----+
|   4 | jai   |      9 |  27 |
+-----+-------+--------+-----+
|   5 | hello |      8 |  27 |
+-----+-------+--------+-----+
in the following query, we do group by S.age, S.rating -> create groups based on a unique pair of S.age, S.rating,
i.e, for each unique age, rating pair in the table, output only a single row
*/
-- select
-- 	S.age,
--     S.rating
-- from
-- 	Sailors S
-- group by
-- 	S.age,
--     S.rating
-- ;
/*
even though there is a single age for 'Nancy', 'jai', 'hello', i.e, 27, the uniqueness is defined by the pair of
S.age, S.rating, for which there are only 2 unique pairs (8, 27) and (9, 27) and that is what we get in the
output:
+=====+========+
| age | rating |
+=====+========+
|  22 |      7 |
+-----+--------+
|  39 |      2 |
+-----+--------+
|  27 |      8 |
+-----+--------+
|  27 |      9 |
+-----+--------+
*/

/*
let's say we only want certain groups in the output, groups that satisfy a particular condition
one way to do this, is to filter output groups using the having clause;
think of having as a condition that will be applied on the output rows produced as the output of
the group by clause, followed by the aggregation defined by the having clause on the output of
the group by clause

in the following statement, we have:
no group by (default group by over whole table), no aggregation in having (default aggregation for each single value): when we don't
have a group by, can we understand it as all rows being different groups and the aggregation is each of the rows value in that column
when we then use having, it will behave like a where clause?
*/
-- select
--     age
-- from
-- 	Sailors
-- having
-- 	age < 30
-- ;

/*
in the following statement, we have:
no group by (default group by over whole table), aggregation in having
here we are aggregating over age and selecting age as well, aggregation will return a single value, which is the avg(age)
in this case, but what should be the age value corresponding to that avg value, i.e,
the age value is ambiguous for the group (the whole table), hence this query is an error
*/
-- select
--     age
-- from
-- 	Sailors
-- having
-- 	avg(age) < 30
-- ;
-- -- to provide an unambiguous value for the age column, we can aggregate it in the select clause
-- select
--     avg(age)
-- from
-- 	Sailors
-- having
-- 	avg(age) < 30
-- ;
-- -- or we can group by the age column, here the aggregation in the having clause happens post the group by
-- select
--     age
-- from
-- 	Sailors
-- group by
-- 	age
-- having
-- 	avg(age) < 30
-- ;
/*
in the above query, the having doesn't make much sense, when we group by age, we have a single value for each group, if we then
find the avg over that single value, we will get the same value because we only have a single value, i.e, the above query and the
following query are equivalent
*/
-- select
--     age
-- from
-- 	Sailors
-- group by
-- 	age
-- having
-- 	age < 30
-- ;
-- -- the following is a more meaningful query
-- select
--     age,
--     avg(rating)
-- from
-- 	Sailors
-- group by
-- 	age
-- having
-- 	avg(rating) > 5
-- ;

-- -- putting it all together, let's say we have a query using everything we have learnt above 
-- select
-- 	S.age,
--     avg(S.rating),
--     count(*)
-- from
-- 	Sailors S
-- where
-- 	S.age < 30
-- group by
-- 	S.age
-- having
-- 	count(*) >= 2
-- order by
-- 	avg(S.rating)
-- ;
/*
how do we read this query to understand/predict the output
let's start from the 'from' clause: from Sailors S -> output rows/tuples from the Sailors table/relation, use S as
an alias for Sailors table;
next we read the where clause: where S.age < 30 -> output only the rows where age is column is less than 30;
next we read the group by clause: group by S.age -> create groups based on S.age, i.e, for each unique age in the
age column, output only a single row;
next we filter the groups created by the group by operation using the having clause: having count(*) >= 2 -> keep
only those groups that have atleast 2 rows;
post this, we don't directly go to the order by, we first select what we want in the output from the set of rows
obtained as the output of above constructs, i.e, for each of the groups, we get the age, the average rating and
the number of elements in that group, we then order by the average rating of each group
*/

/*
the relational model has well-defined query semantics: what this means is that any query that we define has a single
meaning and regardless of the dbms we use, if it follows sql semantics, the ouptut is well defined

sql extends the "pure" relational model with some sql specific features, for eg. duplicate rows (rows that are exactly
the same (all columns values are the same, except the primary key?) but we count them as separate), aggregates, ordering
of output etc.

typically, there is more than one way to write the same query, i.e, that will output the same rows and it is the job of
the dbms to figure out the optimal way to execute that query
*/
