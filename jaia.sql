-- create table Sailors (  sid integer,     sname char(20),     rating integer,     age float);

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

-- always specify date in year-month-date format
-- insert into Reserves values
-- (1, 102, date('2015-9-12')),
-- (2, 102, date('2015-9-13'))
-- ;

-- select * from Reserves;

-- -- select distinct returns all the distinct (col0, col1, ... coln-1) tuples, i.e, the distinct is not just on the
-- -- column name against which you specify it, but over all the columns that follow
-- select distinct
-- 	sid,
-- 	bid
-- from
-- 	Reserves;

-- -- in an order by clause, we first do the ordering on the first column that's specified, if there is a tie on the first column that we
-- -- specify, we break the order on the next column and so on
-- -- order by has to be on columns mentioned in the select clause, coz that's what we are sorting
-- select
-- 	*
-- from
-- 	Sailors
-- order by
-- 	age,
--     rating
-- ;

-- -- each aggregate clause will produce a single row of output for each group
-- here we haven't specified any group, so the group is the whole table
-- select avg(rating) from Sailors;

-- insert into
-- 	Sailors
-- values
-- 	(4, 'jai', 9, 27)
-- ;

-- -- this query is an error, coz the 'avg' aggregate clause returns a single value for a group, since we haven't specified it,
-- -- the group is the whole table, the error here is that how does sql know to return a single value of age for the whole group, i.e,
-- -- what value to chose in the age column for the whole table, therefore, this query is an error
-- select
-- 	age, avg(rating)
-- from
-- 	Sailors;

-- following the previous query, we make sure

