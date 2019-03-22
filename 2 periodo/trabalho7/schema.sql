\c 'pos';
DROP SEQUENCE pkg_winemag_id_seq;
DROP TABLE winemag;
drop table tmp; 

CREATE SEQUENCE pkg_winemag_id_seq;
create table winemag (id integer constraint pkg_winemag_id PRIMARY KEY NOT NULL DEFAULT nextval('pkg_winemag_id_seq'), country varchar(50), description text, designation text, points text, price decimal,  province varchar(50), region_1 varchar(50),region_2 varchar(50), taster_name varchar(50), taster_twitter_handle varchar(50), title text, variety varchar(50), winery text);

CREATE TEMP TABLE tmp AS SELECT * FROM winemag LIMIT 0;
ALTER TABLE tmp
  RENAME COLUMN id TO id_;
ALTER TABLE tmp
	ALTER COLUMN id_ TYPE text;

COPY tmp (id_, country, description, designation,points, price, province, region_1, region_2, taster_name, taster_twitter_handle, title, variety, winery) FROM '/Users/carinabs8/Desktop/pos/2 periodo/trabalho7/winemag.csv' DELIMITER AS ',' CSV HEADER;

INSERT INTO winemag (country, description, designation,points, price, province, region_1, region_2, taster_name, taster_twitter_handle, title, variety,winery)	SELECT country, description, designation,points, price, province, region_1, region_2, taster_name, taster_twitter_handle, title, variety, winery FROM tmp;
drop table tmp; 