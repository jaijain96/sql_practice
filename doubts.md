# mysql_doubts

DBs: hrs given: 165 \[last updated: 1/9/2025\] (started on 16/6/2023); we should at the very least have 500 dbs hrs

* ~~orm: sqlalchemy~~

* DBMS

* sql/rdbms, cap theorem, er diagrams, relatively advanced sql, architecture beneath, sql injection,  acid, base

* ~~plan how to go about dbs when videos completed~~

* reference manuals read and make notes

  * mysql, postgres, ms sql server, oracle, sqlite: references read and make notes, by hand or by typing -> learn whatever you think is important and try to filter out stuff you don’t think is important -> internalize the structure, what are the common patterns for things they are doing and how is each one of them trying to solve it; commonalities and differences

  * check each manual and write down the sections and the order you will do from all, something that makes sense to you right now -> start with mysql reference and for each section, search for similar section in other tutorials -> when done, look for things that were in other references but not in mysql and seem important, so do those and try to find those abt mysql, why are they not in mysql or are they in the reference manual in sections/chapters you missed, search online if you can’t find

    * ch1: preface, general information, introduction

      * this also lists down how mysql deals with constraints, is that section it? or is there more info when we read abt constraints etc. in depth in later sections?

    * ch5: tutorial

    * ch13: data types

    * comparison of innodb clusters and ndb clusters found [here](https://dev.mysql.com/doc/refman/8.4/en/mysql-cluster-compared.html)

      * replication

        * innodb engine supports asynchronous and semi synchronous, no synchronous, also supports group replication

        * ndb supports synchronous within cluster, asynchronous between multiple clusters, no semi synchronous

      * read scaleout: both provide

      * write scaleout

        * innodb would require application level partitioning (to go to different partitions, each cluster for a partition?)

        * ndb provides automatic partitioning

      * k8s operator

        * mysql operator for innodb

        * ndb operator for ndb

    * overview of ndb cluster

    * overview of innodb cluster

    * overview of k8s operator

    * cursory pass over partitioning

    * cursory pass over replication

    * group replication, what does this work with?

    * back to ch13: data types

    * ch14: functions and operators

    * core storage engine: innodb storage engine, alternative storage engines

    * language structure

    * replication

    * innodb cluster, does this support synchronous replication

    * ndb cluster, does this support synchronous replication

    * partitioning

    * go through overview of each chapter to decide which chapter to go through next

    * server administration

    * security

    * connectors and apis; what is odbc sql standard; odbc (open database connectivity) interface: [https://dev.mysql.com/doc/connector-odbc/en/](https://dev.mysql.com/doc/connector-odbc/en/); jdbc: [https://dev.mysql.com/doc/connector-j/en/](https://dev.mysql.com/doc/connector-j/en/) -> what are these, there seems to be something like this available for .net as well, so is there something like this for python?

    * ?mysql enterprise edition

    * ?mysql router

    * db and its object’s design -> design of dbs, tables, constraints, procedures?

    * sql constructs provided by dbms, statements etc. and extensions to it -> extensions you think are good or are helpful

    * handler statement in mysql

    * in a distributed environment, do we deal with mysql operator for k8s -> we don’t, the operator is what helps us deal with the distributed environment, not the other way around

    * check documentation [home page](https://dev.mysql.com/doc/) and [more page](https://dev.mysql.com/doc/index-other.html) to check what to read next

  * doubts from mysql manual

    * mysql documentation states that it can scale to tbs of data and some number of machines in a cluster -> do other dbs optimized for specific cases help to scale beyond these limits? -> why did we ever need new dbs?

    * how do other dbs implement the general basic functions of select, like, where, group by, comparison operators etc. -> how do they perform on those queries

    * how are constraints like foreign key constraints and corresponding integrity checks implemented in other types of databases

    * why are correlated subqueries inefficient as compared left joins or common table expressions with window functions, check 5.6.4 in ref manual for mysql

    * when a db is running, it has been setup in a specific mode, with specific config parameters, when migrating such a db, how do we ensure that we also migrate the existing config parameters as well as continue their same behaviour post migration -> especially in a distributed systems environment -> there are metadata tables, migrating those should fix this problem and ensure same behaviour post migration

    * what is a transactional and non transactional table

    * AUTOINCREMENT, CHECK

    * how are these methods like REGEXP\_LIKE in mysql implemented on a single machine, and how do they work in a distributed environment?

    * how do unique ids translate from api layer to db layer

    * how are spatial data types stored and retrieved efficiently, r-tree indexes and more in a sql db, how do various methods defined on them work, for eg, mbrcontains, how does it work -> how do they work in a distributed environment

    * how are json data types stored and retrieved efficiently, how do various methods defined on them work -> how do they work in a distributed environment

    * there’s a choice whether to offload the task to db layer or do it in the app layer, and it seems that almost always, it would be preferable to offload it to db, but is that always correct? key is to identify when to offload to db layer and when to solve on own

    * how does is\_uuid work? or in general, how do we check whether a string is a uuid, or a hashed string?

* sql practise

  * most common sql clauses from that diagram by bbgo “how to learn sql” -> understand and make notes; sql practice from sites -> lahman database and sql tasks from cs186

  * basic to mid advance sql

  * notes abt alter table, like and regex string match

  * learn from postgres docs or some other docs and practice

    * transactions; views; constraints; roles; indexes; sequences; cte; trigger; with clause; pattern matching: wildcards, regex etc. in sql; merge; all and any; exists; group by, order by, where, having; check constraint

    * how to make sure that each insertion into the table causes a unique value in column or some value based on some programmatic logic -> default keyword? stored procedure? -> we don’t want to make this the responsibility of the code that writes to this db, i.e, application code

* notes

  * ~~watch, understand and make notes of cs186berkley dbms videos \[sql part\]~~

  * watch, understand and make notes of cs186berkley dbms videos \[dbms part\]: set semantics slides notes when making notes -> code out stuff wherever required and push to your own repo

  * how does indexing, partitioning work in case when we want indexing on multiple columns, for eg. for filters on a site, how do we index when what columns to index changes with search query? for eg. say an e-commerce website where the filters to apply change based on the products we are viewing, how to index in that case?

* different db types

  * post making notes and driving concepts home for rdbms from vidoes, check what types of dbs are there from bbgo post on diff db types -> take eg. of 1 famous db of each type -> research docs/resources for components of each db corresponding to the architecture of dbms as mentioned in videos

  * make notes of each component and comparisons with other dbs -> understand why different dbs are performant for use cases they have been optimized for -> where does the shift in responsibility from the db to the application code happen and how are those shifts managed in a distributed environment -> important to understand where the boundary lies between transactions execution and what can be done at application level -> when and how to choose one over the other

  * repeat the above for dbs provided by cloud services

* dbs in a distributed environment

  * for dbs, be sql or nosql, we have multiple components, from the query layer right down to the disk management layer -> how do these components scale out in a shared nothing architecture, in a shared disk architecture and in a shared memory/ram architecture, i.e, how do the data structures and algorithms (for various components) work on a single machine, how they store data on disk and how does it travel over the network (between instances of the dbms and also between the client and the dbms), how is data returned if it is collated and sent back over the network, paginated? cached? not just within the db but what about the web application/service as a whole when it is using nosql or sql dbs behind it -> what are the protocols used over network transfer (not always http, for eg. sql server uses table data stream) and the structure of data between client and service (json, xml, protobuf)

  * get clarity about serializability and isolation levels in dbs, concurrency control (optimistic, pessimistic, mvcc etc.); consensus protocols: paxos, raft

  * the statements that we can issue within a transaction (select, update, delete etc.) are dependent on the isolation level we are using for the transaction (read committed, repeatable read, read uncommitted, serializable), this would also be an issue with nosql dbs? know more abt this, mentioned here: [https://dev.mysql.com/doc/refman/8.4/en/innodb-transaction-isolation-levels.html](https://dev.mysql.com/doc/refman/8.4/en/innodb-transaction-isolation-levels.html)

  * is spanner globally distributed? or distributed across regions? yes it is (how is this done? any of the clouds don’t provide a single gke cluster across multiple regions but they do provide this? are they actually doing it over one cluster internally, are they using a service mesh? what’s the secret sauce? petabit scale network?) -> what if they set up vpc peering in multiple regions and then manually set up a k8s cluster over that and then deploy the db on the k8s cluster and have an operator for the db? some other tech -> what is aws equivalent to spanner? -> aurora, keyspaces, neptune, search abt these, read docs for these

  * how were these distributed dbs being managed before? on scale? without k8s? other container orchestration tools? other vm management tools?

* data modelling

  * data modelling is based on application, api, service? or is application based on data modelling? or we first take in concrete requirements based on the use -> then we define what the application can and cannot do based on data modelling OR we break down the application into subsets/components that interact with different data models and chose the best db for each data model

  * data modeling for dbs based on use cases: step 1 -> know different steps involved in data modeling, what kind of data modeling can be done on which what type of data; step 2 -> know how to burn a use case to every data model it can be modeled to; step 3 -> know that which data model is best for which db; step 4 -> burn the use case to the best data model out of all data models (and we already know the best db for that data model from step 3)

* stats, tsa other analysis using bq

* knowledge of bqml + hadoop, spark, clusters for now -> later in depth knowledge of dbs and their architecture from books -> protocols/patterns of feature engineering (data cleaning, transformation) on structured data from scratch using stats, math in sql, pandas, dask etc. -> famous books for these search online, lak books?

* DISTRIBUTED DATABASES: nosql + (mongo db, cassandra, graphsql, neo4j), their architectures + services in gcloud, aws, architectures; map reduce, flume, apache beam, apache arrow, parquet format

* how to backup and restore various dbs, various storage formats, how to convert from sql db to nosql db and back, would be inefficient but how would that work and how much can u optimize

* BIG DATA: hadoop, spark, pyspark; elastic search; dataproc, bigquery

<br>

reading through the limitations and restrictions sections of each db will help you understand the edge cases for which the db is not performant, you have to model the data around the limitations of the db, and the limitations of the use case, this is the challenge of system design and distributed systems

read the core storage engine in the manual, will help

ch 17, 18, 19, 20, 23, 24, 25, 11, 13, 14, 15, 16, 10,
compile all questions/doubts in one place, organize them and ask gpt and search for answers and compile answers, refer chats with psl msft copilot gpt

post sql and db architecture stuff done for each db, do data modelling, migration for each db type which will further solidify which one to use in which scenario, and how will this impact api design and user experience -> post that do most common dbs, products architecture stuff -> add this to now1

what is a data model specific to the read/write patterns of our application, how to design these effectively -> do we take these things in mind? db we choose, application code and the data model between these 2?

when doing sql practice, know abt performance of queries to better than average at least -> for other dbs too, not just sql dbs

when spreading a database across multiple machines, how do partitioning and replication work? how do both of these work in tandem with each other? especially for a single table

* replication seems straightforward enough -> replay logs etc. across different processes

* if the table has partitions -> each partition is replicated? so the order is partition then replicate? should it be, or what if it is replicate then partition?

*

* what happens if the node on which the table is being stored runs out of storage space? say we start to get this error that we can’t store more rows coz we are out of storage space -> what do we do next?

*

* vertically scale

* seems easy, might need to stop the node and restart with changed storage, might need to make the db aware of more data by mounting it appropriately within the os

* if the table is within a container and only have a small volume attached that the container can access and we run out of the space -> we might be able to vertically scale up the container without downtime by allocating more space within the container, by increasing the size of the mounted volume -> this will eventually again be limited by node size and we fall back to the point above where we would need to vertically scale the node instead of the container

*

* horizontally scale

* say we want to add a machine that has more storage attached so that the existing table can be split across the 2 machines, but for the client, it shouldn’t feel like the table is spread across the 2 machines -> does mysql offer this for a single table? how do we coordinate reads and writes to the table, or basically how does the mysql program coordinate the reads and writes to the table -> is one single db component spread across the 2 machines and communicate via inter process communication protocols OR the same program mysql daemon is replicated on both machines and they coordinate among themselves for giving this feel of external consistency, that the table is one single entity while it is actually split across multiple machines -> how does this coordination work? both for reads and writes? -> for either reads or writes, we need something to load balance that determines which part of the partition should the read/write go to -> is this what partitioning is, coz essentially, when we partition, we spread data of one table between multiple partitions and the same thing is happening here (though the partition split is random)

* for scaling, what network protocols are used, is it tcp/ip? or do they use some other network protocol for efficient transfer of row data, also are there different protocols being used for the nodes to be communicating within themselves to the ones that are being used to communicate with the client

* how is the data serialized, deserialized from being transferred over the network to being stored

*

* how do we paginate the number of records from database and then fetch when we need -> how does the to and fro work between application and db layer, coz in case we have multiple partitions and we are doing separation at application layer, we need to aggregate the query data from multiple partitions at the application layer, and we don’t want to overload the application layer with data -> is there a way to paginate the results in the query to the database itself, similar to what we have for apis -> from a api design perspective -> we need to paginate results, but this would need to work in tandem with what we are fetching from the db, so db results need to be paginated too, is there something that orm provides or something that we can write in sql to paginate the results based on offsets -> yes sql provides limit, offset and cursors which we can use to paginate the results of a query, limit/offset is not great since it still scans the entire table till the offset, instead use key based pagination which uses a column value as key (good if there is an index on this) to limit the results based on the where clause -> what about cursors? -> in the case of key based pagination, the application needs to store the last fetched id and from which partition -> how do we maintain this stickiness at scale, i.e, say application is distributed across multiple processes, and one of those processes receives a client request for pagination to fetch a subset of lots of results, the application would issue a query to the db layer and the process returns the data, at this point the client has the offset for the next pagination request and uses it to hit the api again -> we need to make sure that the pagination request is directed to the warmed up process that last sent the pagination query to the db coz that process is the one which has the key (or id of the column) and the partition id where that key lies -> this is the same problem actually between the client and the application and the application and the db, we need to find the correct process to hit to fetch the data (does this take away from the stateless nature of the application a bit?) -> for the interaction between the client and the application, does the load balancer do this? does the gateway do this? consistent hashing? how does this work in the case when processes are being destroyed and created back (container gets destroyed, network partition etc.); does the application store the key id and the partition id somewhere (is this somewhere the load balancer? dns?) or some service, so it is available to all of its replicas? alleviating the need for load balancer to maintain that stickiness to the same process? extra storage hop? extra ipc hop on same compute? -> if we don’t do partition management at the application and use some extension to the db, like a separate aggregation layer, this layer needs to be managed separately and it would take care of all this id management and pagination on its own, including hitting the replication of the partitions in case the partition process had died for some reason, we only need to issue the query to the aggregation layer -> does it do the same as we are discussing to do at the interaction between the client and the application layer? does this extension store/manage the id of the partition (and its replicas)? does this induce an extra network hop? what if the extension is like a wrapper over the db and deployed on the same location (same compute) as the db so network hop is not there, but there is inter process communication hop though (whose speed is much faster than network hop and is more reliable)? -> how would all this work for write queries? for the same use case, how do we do connection pooling at scale?

* do we plan for partitioning or could it be random? -> hash based -> what happens if disk for a partition gets filled up? -> re-partition same hash? consistent hashing -> move from one disk to another server disk? -> search and think of other problems like this and find answers for them

* for partitioning, the mysql docs say that the db deals with partitioning by storing table partitions at different locations/partitions of a file system -> earlier we were discussing about co-ordinating horizontal scaling of tables via partitions in a shared nothing architecture, but what about, we have like a shared storage? or even dedicated storage -> like a distributed file system, the file system appears as a single unit to the mysql db and it handles partitions over it -> can we do something like this at each layer of db architecture (each layer that was explained in cs berkeley videos) -> distributed each layer? distributed query optimizer? distributed file system? how is isolation and multi-tenancy achieved in a distributed file system? distributed aggregation layer?

* what seems to be the case for mysql partitions, the partitioning is user defined but doesn’t need to happen at application layer (so difficult to change?), the client can simply send inserts and based on the partitioning defined at the db layer, the db inserts into the current logical/physical partition -> so the application can scale independently of the db coz it doesn’t need to know which partition to read/write data from -> but the db needs to be scaled to make this possible -> i currently see only 2 options to do this, first is a shared nothing architecture: this shifts the responsibility of partitioning at scale away from the db since mysql doesn’t provide anything of this sort in its clusters -> either have an aggregation layer (vitess, citus) or do partition management at application layer (doing things at the application layer that need to be done at the aggregation layer); the second is shared storage architecture: we only create a distributed fs and provide it to the db, the db itself determines which partition to read/write data to/from -> would this still need coordination between the different instances of mysql processes? coordination might not be required coz there might not be multiple processes, there could be a single instance of mysqld but the storage layer it deals with is a distributed fs? in this case the aggregation layers seems to be the os and the memory associated with the os which will co-ordinate with the underlying distributed nfs, still, not completely clear on this -> is this again tending to shared nothing architecture among the mysql processes? so is a shared nothing architecture better? -> if mysql allows for separating out its individual process, we might be able to achieve this shared storage architecture? still questions might remain on how to coordinate those processes or how mysql already coordinates them? -> form these thoughts completely, have reasoning for each and every aspect, from theory to k8s, cloud, any other tools in between

* implementing dsa using concurrent algorithms, solving leetcode that way

*

* what is difference between ndb and clustered table since both are in memory?

*

* how do transactions work when a single table is distributed across multiple nodes/pods/containers/processes and they are behind a load balancer, how does the to and fro happen between the application layer and the db layer since the application layer itself would be deployed across multiple nodes/pods/containers/processes, how is the sticky-ness maintained?

* how does a transaction in an acid compliant db do to and fro of data between the app layer and db layer

<br>

for a table, increasing the partitions doesn’t magically lead to better results, it varies from case to case and examples of various use cases need to be understood to understand where and where not increasing or decreasing partitions will help, it will come with practice and creating intuition

how are concurrent joins handled, leave that, how is a single join handled, from a single machine, to scale of multiple machines -> what does this mean? joining when tables lie on different machines -> but mysql doesn’t support this? does it? how are those aggregation layers of vitess and citus solving this issue? how does this work in a non relational distributed db?

big o complexity of functions in dbs and the complexity when the same db is distributed, under various architectures

for dbs, template for every db, common things each db should do and how each different db does that, how they work on a single machine, how do they scale out, would help in comparing dbs

you were right, people are using mysql with nfs, can this help scale out, partitioning a table across machines cause the directory which it is writing to is spread across machines? people complain about the performance, is network the bottleneck? would network not be the bottleneck in share nothing architecture system

how is the autoincrement counter value maintained on scale, how is it kept in sync across multiple processes across machines; there are always chances of autoincrement values not being completely inaccurate in cases of unexpected server exits where the last autoincrement value is not written to the redo log

what is data dictionary in mysql

mysql db (and other dbs) have these caches (buffers) built in for performance, like the log buffer, what happens in case the process goes down (due to any failure) when stuff was in the cache/buffer and hadn’t been written to disk -> that transaction just has to restart? -> how does this work in a distributed environment when at first the transaction might have hit a warmed up application process that issued the transaction and is now hitting some other process -> how is state being synchronized at the application layer? some state at least

* is this where the answer to that question lies? what to put into application layer, what to put at db layer, it’s better to put most at db layer? how is the db itself being managed?

<br>

we are advised to rollback a change on application layer when an error occurs -> what is the best way to do this? -> what if we haven’t committed anything, do we need to rollback then?, what happens if we don’t rollback -> the transaction remains open? locks are held -> it might be the case that during execution of a transaction with autocommit off, we encounter an error and then before rolling back, there is an application crash, does the transaction remain open even then? -> gpt5 answered in this manner

* The transaction remains open only as long as the database connection is alive.
* When the application crashes, the database connection is typically closed by the OS or the connection pool.
* MySQL automatically rolls back any active transaction when the connection closes. This is guaranteed by the InnoDB engine.
* If the app crashes but the connection stays alive (e.g., in a pooled environment where the pool doesn’t detect the crash immediately), the transaction could remain open and hold locks.
* This is why connection pools must reset sessions (usually by issuing ROLLBACK) before reusing them.

what are sockets etc. and how do they work in terms of connection and session objects

how are autoincrement values synchronized on scale -> is there need for this? how is replication effected, what happens when partitioning

each “on scale” problem can be boiled down to a set of data structures and algorithms interacting with each other -> for solving the whole use case, need to solve individual smaller use cases and each smaller use case has a core dsa -> then we need to know the tools to implement these core problems, and limitations of these tools, weighing tools or solutions requires depth of knowledge into how implementations of algorithms within that tool actually solve the problem -> therefore, we need a set of “on scale” considerations to evaluate each tool on
need a set of “on scale” considerations to evaluate each db on, to evaluate mysql methods, for eg. autoincrement, the regex like operator, alter table, ddl, dml statements etc.

* replication
* partitioning
* acid principles
* transactions
