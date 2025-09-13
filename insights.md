# INSIGHTS

## COMMON DESIGN PATTERNS

Each db uses a cache for almost every operation that deals with disk i/o, this is done to speed up performance for
that operation; a separate thread keeps flushing the cache to disk at regular intervals, this is done to ensure
that the data is not lost in case of a crash; the frequency of the flush is configurable and depends on the
importance of the data and the performance requirements of the application

Frequent changes to data (rows/documents etc. that are frequently changed) are present in cache, and not all changes
have yet been flushed to disk, in case that data is being queried, the on disk changes are merged with the changes in
the cache to provide a consistent view of the data

## TEMPLATE TO ASK QUESTIONS IN ORDER TO UNDERSTAND EACH DB

### DATA STRUCTURES

* What different types of data does the db say that it can store?
* The database is a process running on a machine, how are the different data types stored in memory? What data
  structure does the db use for each data type in memory? Each db has a on disk structure, how does the in memory
  structure map to the on disk structure so that there is minimum impedance mismatch between the two, i.e, how does
  the db optimize serialization from memory to disk and back? But the db is composed of multiple layers, the query
  parser, the optimizer, the executor etc., is it futile at this point to try to understand how each layer stores the
  data structure in memory and how does the data flow through these layers? Would it suffice to know what
  classes (data structure) are involved in each layer and what are the main functions of each class?
* How is data laid out on disk? How is the disk file structured in order to represent each data type?

### ALGORITHMS

* How do common crud operations work from the in memory structures to the on disk structures? How are these optimized
  for the type of data that the db stores?
  * if the db claims that is a rdbms, how do common crud operations work on the tables, rows, columns etc.
  * if the db claims it is document store, how do common crud operations work on the documents, fields etc.
  * if the db claims it is a graph db, how do common crud operations work on the nodes, edges etc.
  * if the db claims it is a key value store, how do common crud operations work on the keys, values etc.
  * if the db claims it is a columnar db, how do common crud operations work on the columns, rows etc.
  * if the db claims it is a time series db, how do common crud operations work on the time series data etc.
  * if the db claims it is a text based db, how do common crud operations work on the text data etc.
  
  What is the runtime complexity of each of the crud operations for each of these dbs?

* What are the specialized operations that the db offers? How do these specialized operations work from the in memory
  structures to the on disk structures? How are these optimized for the type of data that the db stores?

  What is the runtime complexity of each of the specialized operations for each of these dbs? What would it take to
  implement these operations on a different type of db? How would the runtime complexity change?

* How are the components: query language, the query parser, the query optimizer, the query
  executor optimized for the type of data that the db stores? Are there any special components that each db has for its
  specific operations, what is the core algorithm for each of these components? Are the indexes and log structures part
  of these specific components? What are the different types of indexes that the db offers? How are they implemented?
  How does the db decide which index to use for a query?
* How do the crud and specialized operations work for read requests in a single thread?
* How do the crud and specialized operations work for write requests in a single thread?
* How do the crud and specialized operations work for read requests from 2 or more threads?
* How do the crud and specialized operations work for write requests from 2 or more threads?
* How do the crud and specialized operations work when there are concurrent read and write requests from 2 or more
  threads?
* How do the crud and specialized operations scale with the number of concurrent requests?
* How do the crud and specialized operations scale with the size of the data?

### RECOVERY

* How does the db handle crashes when running on a single machine? A crash can occurr at any time when the db is
  running, for the common crud, and various specialized operations, the majority of the crashes could be boiled down
  to a few specific types of crashes, what are those?
* How does the db handle each of the above types of crashes? What are the in memory and on disk structures that are
  used for implementation? What are the algorithms used on those structures? What is the runtime complexity of the
  implementation as a result of these data structures and algorithms?

### NETWORKING

* How does the db handle network communication? What network protocol is used? What is the format of the network
  packets? How is data serialized and deserialized for network transfer? How similar/different, is this to an api
  framework running within a web server process?
* What is the network protocol used for communication between the client and the server and the server and other
  servers in a distributed environment?
* What happens when a client initiates a connection to the db?

### SECURITY

#### DATA STRUCTURE SECURITY

* How is data kept secure in memory and on disk? How is data kept secure in transit? What are the in memory and
  on disk structures that are used for implementation? What are the algorithms used on those structures? What is the
  runtime complexity of the implementation as a result of these data structures and algorithms?

#### ALOGIRHTMS SECURITY: AUTHN, AUTHZ

* What is the authentication and authorization framework used by the db? What are the different types of
  authentication and authorization methods supported by the db? What are the in memory and on disk structures that are
  used for implementation? What are the algorithms used on those structures? What is the runtime complexity of the
  implementation as a result of these data structures and algorithms?

### TELEMETRY

* What is the logging, tracing, monitoring and alerting framework used by the db? What are the different types of
  metrics that the db exposes? What are the different types of alerts that the db raises? What are the in memory and
  on disk structures that are used for implementation? What are the algorithms used on those structures? What is the
  runtime complexity of the implementation as a result of these data structures and algorithms?

* How does the db handle failover? How does the db handle failover in a distributed environment?
* How does the db handle replication? How does the db handle partitioning? How does the db handle sharding?
