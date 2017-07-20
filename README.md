# Database updates for bbPress
> Proposed new database schema for bbPress.

## Why database need to be changed

The new schema is proposed to use additional table as a replacement for the use of wp_postmeta for storing additional data used by forums, topics and replies. Database queries that need to join with the data in the wp_postmeta are very slow because join in the SQL is made on the meta_value column (type is LONGTEXT). This column can't be indexed, and it requires casting to get proper data format, and that makes SQL queries execution very slow.

The speed of bbPress queries that depend on the wp_postmeta joining is not critical issue for small forums, but for larger number of topics and replies, it can considerably slowdown the website for more complex queries.

