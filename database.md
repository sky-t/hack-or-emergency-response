#Database Notes

These are the basic steps I followed in order to get the crimes table up on the EC2 police db. The basic approach I took was to download the NIJ files, convert them to csv, then copy them into duplicate tables in the postgres db. Once in the db, I used INSERT queries to append all the years' data into a single crimes table with a new column ID added as a PK.

1. I began by downloading the data from the NIJ [site](https://www.nij.gov/funding/pages/fy16-crime-forecasting-challenge.aspx#data)
2. Since the data was in .xlsx I used $ in2csv to convert the excel files to csv
3. Using $ csvsql I created table schemas for each csv (all years 2012-2015, then 4 csvs for 2016 so far). SQL for the basic schema was as follows
```
CREATE TABLE nij_2012 (
        CATEGORY VARCHAR(19) NOT NULL,
        CALL_GROUP VARCHAR(18) NOT NULL,
        final_case_type VARCHAR(6) NOT NULL,
        CASE_DESC VARCHAR(43) NOT NULL,
        occ_date DATE NOT NULL,
        x_coordinate INTEGER NOT NULL,
        y_coordinate INTEGER NOT NULL,
        census_tract INTEGER
);

CREATE TABLE crimes (
  ID serial PRIMARY KEY,
  category character varying(19) NOT NULL,
  call_group character varying(18) NOT NULL,
  final_case_type character varying(6) NOT NULL,
  case_desc character varying(43) NOT NULL,
  occ_date date NOT NULL,
  x_coordinate integer NOT NULL,
  y_coordinate integer NOT NULL,
  census_tract integer);
```
4. I imported data for each csv into the postgres db on the EC2 instance using the psql \COPY function. This [link](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/PostgreSQL.Procedural.Importing.html) was helpful.

```
$psql target-db \
  -U <admin user> \ 
  -p <port> \ 
  -h <DB instance name> \ 
  -c "\copy source-table from 'source-table.csv' (FORMAT CSV, HEADER)"
  ```
5. I then used INSERT INTO to append data to the crimes table
```
INSERT INTO nij.crimes
  (category,
  call_group,
  final_case_type,
  case_desc,
  occ_date,
  x_coordinate,
  y_coordinate,
  census_tract)
SELECT
  category,
  call_group,
  final_case_type,
  case_desc,
  occ_date,
  x_coordinate,
  y_coordinate,
  census_tract
FROM nij.nij_2015;
```
  
