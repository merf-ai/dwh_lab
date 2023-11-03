CREATE DATABASE "DWH_2"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Russian_Russia.1251'
    LC_CTYPE = 'Russian_Russia.1251'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
CREATE TABLE IF NOT EXISTS student_hub(
	passport_number integer,
	passport_series integer,
	load_time time NOT NULL default current_time,
	data_origin text,
	PRIMARY KEY(passport_number, passport_series)
);

CREATE TABLE IF NOT EXISTS student_data_sat(
	load_time time NOT NULL default current_time,
	passport_number integer,
	passport_series integer,
	name character(200),
    surname character(200),
    patronymic character(200),
    group_number character(10),
    email text,
    phone_number text,
    course_number integer,
	data_origin text,
	FOREIGN KEY (passport_number, passport_series) REFERENCES student_hub (passport_number, passport_series),
	PRIMARY KEY(load_time, passport_number, passport_series)

);

CREATE TABLE IF NOT EXISTS education_direction_sat(
	load_time time NOT NULL default current_time,
	passport_number integer,
	passport_series integer,
	name text,
	direction_number text,
	data_origin text,
	FOREIGN KEY (passport_number, passport_series) REFERENCES student_hub (passport_number, passport_series),
	PRIMARY KEY(load_time, passport_number, passport_series)
);

CREATE TABLE IF NOT EXISTS faculcy_sat(
	load_time time NOT NULL default current_time,
	passport_number integer,
	passport_series integer,
	name text,
	data_origin text,
	FOREIGN KEY (passport_number, passport_series) REFERENCES student_hub (passport_number, passport_series),
	PRIMARY KEY(load_time, passport_number, passport_series)
);

CREATE TABLE IF NOT EXISTS event_hub(
	code text PRIMARY KEY,
	load_time time NOT NULL default current_time,
	data_origin text
);

CREATE TABLE IF NOT EXISTS adress_sat(
	load_time time NOT NULL default current_time,
	code text,
	city_name text,
	street_type text,
	street_name text,
	build_number text,
	data_origin text,
	FOREIGN KEY(code) REFERENCES event_hub (code),
	PRIMARY KEY(load_time, code)
);


CREATE TABLE IF NOT EXISTS event_data_sat(
	load_time time NOT NULL default current_time,
	code text,
	name text,
	date_start time,
	date_end time,
	description text,
	data_origin text,
	FOREIGN KEY(code) REFERENCES event_hub (code),
	PRIMARY KEY(load_time, code)
);

CREATE TABLE IF NOT EXISTS company_hub(
	load_time time NOT NULL default current_time,
	inn text,
	kpp text,
	ogrn text,
	data_origin text,
	PRIMARY KEY(inn, kpp, ogrn)
);

CREATE TABLE IF NOT EXISTS company_sat(
	load_time time NOT NULL default current_time,
	inn text,
	kpp text,
	ogrn text,
	name text,
	phone_number text,
	email text,
	data_origin text,
	FOREIGN KEY(inn, kpp, ogrn) REFERENCES company_hub (inn, kpp, ogrn)
);

CREATE TABLE IF NOT EXISTS event_student_link(
	id integer GENERATED ALWAYS AS IDENTITY,
	passport_number integer,
	passport_series integer,
	code text,
	load_time time NOT NULL default current_time,
	data_origin text,
	is_visited boolean,
	FOREIGN KEY(passport_number, passport_series) REFERENCES student_hub (passport_number, passport_series),
	FOREIGN KEY (code) REFERENCES event_hub (code),
	PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS event_company_link(
	id integer GENERATED ALWAYS AS IDENTITY,
	load_time time NOT NULL default current_time,
	data_origin text,
	inn text,
	kpp text,
	ogrn text,
	FOREIGN KEY(inn, kpp, ogrn) REFERENCES company_hub (inn, kpp, ogrn),
	FOREIGN KEY (code) REFERENCES event_hub (code),
	PRIMARY KEY(id)
);
