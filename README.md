Database updates for bbPress
============================
> Proposed new database schema for bbPress to imporve speed of database queries by no longer using wp_postmeta for additional forum, topic and reply data.

## Why database need to be changed?

The new schema is proposed to use additional table as a replacement for the use of wp_postmeta for storing additional data used by forums, topics and replies. Database queries that need to join with the data in the wp_postmeta are very slow because join in the SQL is made on the meta_value column (type is LONGTEXT). This column can't be indexed, and it requires casting to get proper data format, and that makes SQL queries execution very slow.

The speed of bbPress queries that depend on the wp_postmeta joining is not critical issue for small forums, but with larger number of topics and replies, it can considerably slowdown the website for more complex queries.

Without these changes, bbPress can't scale well to large forums that run complex queries or have features that need better filtering, search and other things that use complex queries.

## Which new tables are needed?

This proposition currently includes 3 tables for forums, topics and replies, 2 tables for topics and forums subscriptions and 1 table for favorite topics.

Tables for forums, topics and replies are made to replicate data saved into wp_postmeta table. Each column in these tables corresponds to the meta field stored in the wp_postmeta table. All ID based columns are indexed to make required joins very fast. Proper data types are used for all columns.

## How much faster queries can be?

From my own preliminary testing, complex queries can be 50 times faster. This doesn't mean that bbPress will be 50 times faster, it all depends on the size of the forums, user activity and other things.

My plugin [GD bbPress Toolbox Pro](https://plugins.dev4press.com/gd-bbpress-toolbox/) uses custom database tables to track read status for topics and forums, and uses one extra table with indexed ID columns. First version of the code was made with the use of wp_postmeta. On a small forum (under 1000 forums, topics and replies combined), custom table based queries were only 2 times faster then the post meta based query. But, with larger forum with up to 100000 posts, custom table based queries were 30 times faster, and with a forum with 250000 posts, queries were almost 60 times faster.

Similar improvements are expected for bbPress core when transitioned to the custom database tables.

## How much work is needed to make changes to the bbPress?

There are few things that needs to be done:

* Add install script to create database tables.
* Create central database handling object for writing and reading from the extra tables.
* Modify the forum maintenance code to recalculate all the data into new tables.
* Create migration tool to guide user through the update process.
* Replace all post meta handling functions (add, update, delete) with new code.
* Modify all SQL queries to use new tables.
* Modify all WP_Query based code to use new tables.
* Update all the converters to use new database object.

## What is next?

I would like to see suggestions on how to improve the database tables and make sure they are future proof and that bbPress can be updated and modified to use them.

That's it for now,

**Milan Petrovic**
Website: https://www.dev4press.com/
Twitter: https://twitter.com/milangd
Facebook: https://www.facebook.com/dev4press
