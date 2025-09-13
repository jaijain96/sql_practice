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

### DATA STRUCTURE PART

* What different types of data does the db say that it can store?
* The database is a process running on a machine, how are the different data types stored in memory? What data
  structure does the db use for each data type in memory? Each db has a on disk structure, how does the in memory
  structure map to the on disk structure so that there is minimum impedance mismatch between the two, i.e, how does
  the db optimize serialization from memory to disk and back? But the db is composed of multiple layers, the query
  parser, the optimizer, the executor etc., is it futile at this point to try to understand how each layer stores the
  data structure in memory and how does the data flow through these layers? Would it suffice to know what
  classes (data structure) are involved in each layer and what are the main functions of each class?
* How is data laid out on disk? How is the disk file structured in order to represent each data type?

### ALGORITHM PART

*
* How are the components: query language, the query parser, the query optimizer, the query
  executor optimized for the type of data that the db stores? Are there any special components that each db has for its
  specific operations, what is the core algorithm for each of these components? Are the indexes and log structures part
  of these specific components? What are the different types of indexes that the db offers? How are they implemented?
  How does the db decide which index to use for a query?

### NETWORK PART

* How does the db handle network communication? What network protocol is used? What is the format of the network
  packets? How is data serialized and deserialized for network transfer? How similar/different, is this to an api
  framework running within a web server process?
*
