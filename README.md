# Comment Search

This web app allow users to search for comments containing an exact phrase.

## Set up

1. Run a MySQL server locally 
2. Create a new database `create database code_test` 
3. Load the data (in a file outside this repo) `cat code_test_sql_dump.sql | mysql -uroot code_test`
4. Install the gems `bundle`
5. In line 2 of app.rb, replace "root:" with <your mysql user>:<password>
6. Run the Sinatra server `shotgun`
7. Navigate browser to `http://127.0.0.1:9393/`

## How to Scale It

This app currently uses `LIKE` with wildcards in a SQL query, a brute-force method that will take a while.

There's a higher performance design called an inversion index, used in technologies such as MS SQLServer's Full-Text Search and, I think, Apache Lucene. It allows for finding two words near each other and words derived from the same root. It takes more space but is a lot faster.

An inversion index involves two tables, one that has every single word within the data, and another that has the location (usually the offset) of every instance of the word. 

To scale the front-end, I would paginate the results.
To scale for higher traffic, I would add more web server instances behind a load balancer.

## Development

To open the database locally: `mysql -h localhost -u root -p`

## Method

One challenge here was to find the right threshold between offensive and not, the right score to filter on.When I bucketed the comments based on their scores (each bucket had a range), I saw that the vast majority of the scores are less than 0.3. That probably means the scoring is not overly sensitive. I ended up filtering to display only comments with a max summary score of 0.4, which means only one in ten or twenty comments is deemed offensive and returned by the search. A better statistical way to find the right threshold might be with a logit graph for each score, and then choose a point where the graph is steepest.