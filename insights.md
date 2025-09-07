# INSIGHTS

## COMMON DESIGN PATTERNS

Each db uses a cache for almost every operation that deals with disk i/o, this is done to speed up performance for
that operation; a separate thread keeps flushing the cache to disk at regular intervals, this is done to ensure
that the data is not lost in case of a crash; the frequency of the flush is configurable and depends on the
importance of the data and the performance requirements of the application
