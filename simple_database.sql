CREATE DATABASE DWH_2;
CREATE TABLE IF NOT EXISTS faculty (
	id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	name char(200)
);

CREATE TABLE IF NOT EXISTS educational_direction (
	id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,,
	name char(200)
);

CREATE TABLE IF NOT EXISTS student (
	id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,,
	name char(200),
	surname char(200),
	patronymic char(200),
	group_number char(10),
	email citext UNIQUE,
	phone_number text UNIQUE,
	faculty_id integer references faculty (id),
	educational_direction_id integer references educational_direction (id),
	course_number integer
);

CREATE TABLE IF NOT EXISTS educational_event (
	id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,,
	name char(200),
	begin_datetime timestamp,
	end_datetime timestamp,
	description text
);


CREATE TABLE IF NOT EXISTS record (
	id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,,
	student_id integer references student (id),
	educational_event_id integer references educational_event (id),
	is_visited boolean
);

CREATE TABLE IF NOT EXISTS organizing_company (
	id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,,
	name char(200),
	email citext UNIQUE,
	inn char(12),
	ogrn char(20),
	kpp char(30)
);

CREATE TABLE IF NOT EXISTS organizing_company_and_events (
	id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,,
	organizing_company_id integer references organizing_company (id),
	educational_event_id integer references educational_event (id)
);

CREATE TABLE IF NOT EXISTS street_type (
	id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,,
	name char(200)
);

CREATE TABLE IF NOT EXISTS street (
	id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,,
	name char(200),
	street_type_id integer references street_type (id)
);

CREATE TABLE IF NOT EXISTS city (
	id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,,
	name char(200)
);

CREATE TABLE IF NOT EXISTS adress (
	id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,,
	street_id integer references street (id),
	city_id integer references city (id),
	build_number integer
);

CREATE TABLE IF NOT EXISTS educational_event_end_adress (
	id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,,
	adress_id integer references adress (id),
	educational_event_id integer references educational_event (id)
);
