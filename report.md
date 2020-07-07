# Overview
## About the Data
(copying from what I wrote in homework 3)
1. Name: League Year-By-Year Batting--Averages
2. Link to Data: https://www.baseball-reference.com/leagues/MLB/bat.shtml#
3. This data is average stats for the whole league per year and it was collected in part by Baseball Reference with the majority of it from RetroSheet.org.
4. I'm a huge baseball fan; been watching since I was 7. So, I thought it seemed fitting to parse data about it.

Additional notes:
- For the amount of columns the original csv has, it has 28. 
- As for the data types, columns Year, Tms, G (Games) and #Bat are all integers while the rest are floats. The only exception is RBI which is considered an object even though all the values seem to be float values. This has to do with the fact that it originally had 3 rows written as '--' for whatever reason I can't understand at the moment. 
- Compared to the original csv file vs the altered csv file that's used in this table, I removed the runs scored column labeled as 'R' since it was all the same values as 'R/G'. Additionally, I added 0.00 as a default value for null values in the csv file.

# Table Design
- In my table, I decided to make years my primary key since it's a column that's unique and guaranteed to not be null
- Secondly, I decided to include null values by defaulting them to 0.00 (I did that clean up in convert.ipynb). I decided to include those in because null values only happened for roughly half of the rows and only affected a max of 5 columns within one year (the null values mainly appeared from baseball's inception to the early 1950s as some stats weren't kept). I made every floating point number numeric since I would like to maintain the exactness of it when doing calculations, even if it meant a slower performance.
- Lastly, for the fields that were int to begin with, I made all of them type integer except teams. I made teams smallint since its highest value was 33, so it doesn't need all that space. I made the others integer since those columns reached into the thousands, which is definitely larger than what 2 bytes can handle.

# Import
- Initially when trying to import the csv, I would get a permissions denied error on it. I didn't find an exact fix for it but instead I found a quick fix by allowing read permissions to everyone (which I'll make sure to remove once this is all doone).
- Another issue that arose that was more so due to how I created the table was that for some columns, there was data overflow. It had to do with having an incorrect precision value with some of the columns. Once that was fixed, the csv file imported without a problem.

# Database Information
```
                                                  List of databases
    Name     |  Owner   | Encoding |          Collate           |           Ctype            |   Access privileges   
-------------+----------+----------+----------------------------+----------------------------+-----------------------
 homework_06 | postgres | UTF8     | English_United States.1252 | English_United States.1252 | 
 postgres    | postgres | UTF8     | English_United States.1252 | English_United States.1252 | 
 template0   | postgres | UTF8     | English_United States.1252 | English_United States.1252 | =c/postgres          +
             |          |          |                            |                            | postgres=CTc/postgres
 template1   | postgres | UTF8     | English_United States.1252 | English_United States.1252 | =c/postgres          +
             |          |          |                            |                            | postgres=CTc/postgres
(4 rows)
```

```
             List of relations
 Schema |     Name      | Type  |  Owner   
--------+---------------+-------+----------
 public | baseball_data | table | postgres
(1 row)
```
```
                   Table "public.baseball_data"
       Column        |     Type     | Collation | Nullable | Default 
---------------------+--------------+-----------+----------+---------
 year                | integer      |           | not null | 
 teams               | smallint     |           |          | 
 batters             | integer      |           |          | 
 avg_batter_age      | numeric(3,1) |           |          | 
 runs_per_game       | numeric(4,2) |           |          | 
 games               | integer      |           |          | 
 plate_appearances   | numeric(4,2) |           |          | 
 at_bats             | numeric(4,2) |           |          | 
 hits_per_game       | numeric(4,2) |           |          | 
 doubles_per_game    | numeric(3,2) |           |          | 
 triples_per_game    | numeric(3,2) |           |          | 
 homeruns_per_game   | numeric(3,2) |           |          | 
 runs_batted_in      | numeric(3,2) |           |          | 
 stolen_bases_avg    | numeric(3,2) |           |          | 
 caught_stealing_avg | numeric(3,2) |           |          | 
 walks_per_game      | numeric(3,2) |           |          | 
 strikeouts_per_game | numeric(3,2) |           |          | 
 batting_avg         | numeric(3,3) |           |          | 
 on_base_percentage  | numeric(3,3) |           |          | 
 slugging            | numeric(3,3) |           |          | 
 on_base_slugging    | numeric(3,3) |           |          | 
 total_bases         | numeric(4,2) |           |          | 
 double_plays        | numeric(3,2) |           |          | 
 hit_by_pitch        | numeric(3,2) |           |          | 
 sacrifice_bunts     | numeric(3,2) |           |          | 
 sacrifice_flies     | numeric(3,2) |           |          | 
 intentional_walks   | numeric(3,2) |           |          | 
Indexes:
    "baseball_data_pkey" PRIMARY KEY, btree (year)
```


# Query Results

**Note: Many of the results include year because I want to demonstrate what year these other stats came from**

1. The total number of rows in the database
```
 rows 
------
  149
(1 row)
```

2. Show the first 15 rows, but only display 3 columns (your choice)
```
 year | batting_avg | runs_batted_in 
------+-------------+----------------
 2019 |       0.252 |           4.63
 2018 |       0.248 |           4.24
 2017 |       0.255 |           4.44
 2016 |       0.255 |           4.27
 2015 |       0.254 |           4.04
 2014 |       0.251 |           3.86
 2013 |       0.253 |           3.96
 2012 |       0.255 |           4.11
 2011 |       0.255 |           4.08
 2010 |       0.257 |           4.17
 2009 |       0.262 |           4.40
 2008 |       0.264 |           4.44
 2007 |       0.268 |           4.58
 2006 |       0.269 |           4.63
 2005 |       0.264 |           4.37
(15 rows)
```

3. Do the same as above, but choose a column to sort on, and sort in descending order
```
 year | batting_avg | runs_batted_in 
------+-------------+----------------
 1871 |       0.287 |           7.02
 1894 |       0.309 |           6.25
 1873 |       0.290 |           5.86
 1872 |       0.285 |           5.83
 1895 |       0.296 |           5.51
 1893 |       0.280 |           5.45
 1930 |       0.296 |           5.16
 1896 |       0.290 |           5.08
 1897 |       0.292 |           4.94
 1887 |       0.271 |           4.91
 2000 |       0.270 |           4.89
 1874 |       0.273 |           4.85
 1999 |       0.271 |           4.83
 1936 |       0.284 |           4.82
 1929 |       0.289 |           4.80
(15 rows)
```

4. add a new column without a default value
```
ALTER TABLE
 year | slug_minus_bat_avg 
------+--------------------
 2019 |                   
 2018 |                   
 2017 |                   
 2016 |                   
 2015 |                   
 2014 |                   
 2013 |                   
 2012 |                   
 2011 |                   
 2010 |                   
 2009 |                   
 2008 |                   
 2007 |                   
 2006 |                   
 2005 |                   
(15 rows)
```

5. set the value of that new column
```
ALTER TABLE
UPDATE 149
 year | slug_minus_bat_avg 
------+--------------------
 2019 |              0.183
 2018 |              0.161
 2017 |              0.171
 2016 |              0.162
 2015 |              0.151
 2014 |              0.135
 2013 |              0.143
 2012 |              0.150
 2011 |              0.144
 2010 |              0.146
 2009 |              0.156
 2008 |              0.152
 2007 |              0.155
 2006 |              0.163
 2005 |              0.155
(15 rows)
```
6. show only the unique (non duplicates) of a column of your choice

```
 teams 
-------
    33
    30
    28
    26
    25
    24
    20
    18
    17
    16
    14
    13
    12
    11
     9
     8
     6
(17 rows)
```

7. group rows together by a column value (your choice) and use an aggregate function to calculate something about that group

```
 teams | seasons | avg_hits 
-------+---------+----------
    33 |       1 |     8.61
    30 |      22 |     8.91
    28 |       5 |     9.20
    26 |      16 |     8.82
    25 |       1 |     9.15
    24 |      10 |     8.49
    20 |       7 |     8.35
    18 |       1 |     8.76
    17 |       1 |     8.89
    16 |      64 |     9.04
    14 |       1 |     9.03
    13 |       1 |     9.87
    12 |       8 |     9.94
    11 |       1 |    12.20
     9 |       2 |    12.30
     8 |       6 |     9.82
     6 |       2 |     9.96
(17 rows)
```

8. now, using the same grouping query or creating another one, find a way to filter the query results based on the values for the groups

```
 teams | seasons | avg_hits 
-------+---------+----------
    30 |      22 |     8.91
    28 |       5 |     9.20
    26 |      16 |     8.82
    24 |      10 |     8.49
    20 |       7 |     8.35
    16 |      64 |     9.04
    12 |       8 |     9.94
     9 |       2 |    12.30
     8 |       6 |     9.82
     6 |       2 |     9.96
(10 rows)
```

9. find the average number of batters per team each year had in the last 30 years
```
year | avg_batters_per_team 
------+----------------------
 2019 |                   42
 2018 |                   42
 2017 |                   40
 2016 |                   41
 2015 |                   41
 2014 |                   40
 2013 |                   40
 2012 |                   39
 2011 |                   39
 2010 |                   38
 2009 |                   38
 2008 |                   39
 2007 |                   39
 2006 |                   37
 2005 |                   38
 2004 |                   37
 2003 |                   37
 2002 |                   36
 2001 |                   37
 2000 |                   37
 1999 |                   37
 1998 |                   36
 1997 |                   37
 1996 |                   32
 1995 |                   32
 1994 |                   27
 1993 |                   32
 1992 |                   31
 1991 |                   31
 1990 |                   31
(30 rows)

```

10. see if age affects batting average and runs batted in 
```
 avg_batter_age | batting_avg | runs_batted_in 
----------------+-------------+----------------
           27.8 |       0.295 |           5.85
           24.0 |       0.290 |           5.86
           23.9 |       0.287 |           7.02
           23.5 |       0.285 |           5.83
           28.2 |       0.275 |           4.24
           25.0 |       0.273 |           4.85
           26.7 |       0.271 |           4.91
           28.1 |       0.271 |           4.22
           25.9 |       0.271 |           3.92
           29.1 |       0.269 |           4.74
           28.9 |       0.269 |           4.48
           28.6 |       0.267 |           3.94
           28.3 |       0.267 |           4.30
           27.9 |       0.267 |           4.41
           27.1 |       0.266 |           3.77
           25.3 |       0.265 |           3.82
           28.4 |       0.265 |           4.21
           26.9 |       0.264 |           4.69
           29.3 |       0.263 |           4.22
           28.8 |       0.263 |           4.42
           29.2 |       0.263 |           4.36
           28.0 |       0.262 |           4.20
           28.5 |       0.261 |           4.07
           29.0 |       0.261 |           4.07
           27.0 |       0.260 |           4.58
           29.7 |       0.260 |           3.86
           28.7 |       0.257 |           3.91
           26.4 |       0.257 |           0.00
           24.7 |       0.256 |           3.74
           27.4 |       0.254 |           3.75
           27.2 |       0.254 |           3.25
           25.7 |       0.254 |           1.85
           26.8 |       0.253 |           3.70
           27.6 |       0.251 |           3.67
           27.3 |       0.249 |           3.56
           24.8 |       0.245 |           3.27
           27.5 |       0.245 |           3.58
           26.6 |       0.244 |           3.64
           25.4 |       0.243 |           0.00
(39 rows)
```

11. show the strikeout rate and batting avg in the most recent year for baseball and for
the first year of baseball
```
 year | strikeouts_per_game | batting_avg 
------+---------------------+-------------
 2019 |                8.81 |       0.252
(1 row)

 year | strikeouts_per_game | batting_avg 
------+---------------------+-------------
 1871 |                0.69 |       0.287
(1 row)

```

12. Show rows where the stolen base rate was > 0.25 and the caught stealing rate was < 0.25 while
excluding years where caught stealing stats weren't kept
```
year | stolen_bases_avg | caught_stealing_avg 
------+------------------+---------------------
 2019 |             0.47 |                0.17
 2018 |             0.51 |                0.20
 2017 |             0.52 |                0.19
 2016 |             0.52 |                0.21
 2015 |             0.52 |                0.22
 2014 |             0.57 |                0.21
 2013 |             0.55 |                0.21
 2012 |             0.66 |                0.23
 2010 |             0.61 |                0.23
 2009 |             0.61 |                0.23
 2008 |             0.58 |                0.21
 2007 |             0.60 |                0.21
 2006 |             0.57 |                0.23
 2005 |             0.53 |                0.22
 2004 |             0.53 |                0.23
 2003 |             0.53 |                0.23
 1965 |             0.45 |                0.24
 1964 |             0.36 |                0.22
 1963 |             0.38 |                0.24
 1962 |             0.42 |                0.22
 1961 |             0.37 |                0.21
 1960 |             0.37 |                0.22
 1959 |             0.34 |                0.20
 1958 |             0.30 |                0.21
 1957 |             0.31 |                0.23
 1956 |             0.29 |                0.20
 1955 |             0.28 |                0.22
 1954 |             0.28 |                0.21
 1953 |             0.27 |                0.21
 1951 |             0.35 |                0.24
 1950 |             0.26 |                0.21
 1940 |             0.39 |                0.13
 1939 |             0.39 |                0.14
 1938 |             0.37 |                0.13
 1937 |             0.41 |                0.14
 1936 |             0.39 |                0.13
 1935 |             0.36 |                0.13
 1934 |             0.37 |                0.13
 1933 |             0.35 |                0.15
 1932 |             0.40 |                0.17
 1931 |             0.44 |                0.18
 1930 |             0.44 |                0.17
 1929 |             0.54 |                0.21
 1928 |             0.52 |                0.20
 1927 |             0.58 |                0.21
 1926 |             0.52 |                0.20
 1874 |             0.52 |                0.21
(47 rows)

```