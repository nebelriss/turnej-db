/*
 * --------------------
 * Enums
 * --------------------
 */

-- Crate enum types
CREATE TYPE status_type AS ENUM ('ACTIVE', 'INACTIVE', 'DELETED');
CREATE TYPE role_type AS ENUM ('SU_ADMIN', 'ADMIN', 'USER');

/*
 * --------------------
 * Tables
 * --------------------
 */

 -- Create Table: puclic.users
 CREATE TABLE public.users (
  id SERIAL,
  status status_type NOT NULL DEFAULT 'ACTIVE',
  name character varying(255) NOT NULL,
  username character varying(255) NOT NULL,
  password character varying(255) NOT NULL,
  salt character varying(255) NOT NULL,
  role role_type NOT NULL DEFAULT 'ADMIN',
  created_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified_at timestamp with time zone,
  version integer NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE (username)
);

-- Create Table: public.seasons
CREATE TABLE public.seasons (
  id SERIAL,
  status status_type NOT NULL DEFAULT 'ACTIVE',
  name character varying(255),
  event_date timestamp with time zone,
  location character varying(255),
  completed boolean DEFAULT false,
  locked boolean DEFAULT false,
  created_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified_at timestamp with time zone,
  version integer NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
);

-- Create Table: public.players
CREATE TABLE public.players (
  id SERIAL,
  status status_type NOT NULL DEFAULT 'ACTIVE',
  user_id integer NOT NULL REFERENCES users (id),
  name character varying(255),
  created_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified_at timestamp with time zone,
  version integer NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
);

-- Create Table: puclic.users_seasons
CREATE Table public.users_seasons (
  id SERIAL,
  user_id integer NOT NULL REFERENCES users (id),
  season_id integer NOT NULL REFERENCES seasons (id),
  created_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified_at timestamp with time zone,
  version integer NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
);

-- Create Table: puclic.seasons_players
CREATE Table public.seasons_players (
  id SERIAL,
  season_id integer NOT NULL REFERENCES seasons (id),
  player_id integer NOT NULL REFERENCES players (id),
  created_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified_at timestamp with time zone,
  version integer NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
);

-- Create Table: public.games
CREATE TABLE public.games (
  id SERIAL,
  status status_type NOT NULL DEFAULT 'ACTIVE',
  season_id integer REFERENCES seasons (id),
  user_id integer REFERENCES users (id),
  player_home_id integer REFERENCES players (id),
  player_home_goals integer,
  player_away_id integer REFERENCES players (id),
  player_away_goals integer,
  created_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified_at timestamp with time zone,
  version integer NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
);


/*
 * --------------------
 * Views
 * --------------------
 */

-- TODO: Create View: game_tables
CREATE VIEW game_tables AS
SELECT * FROM games;


/*
 * --------------------
 * Trigger Functions
 * --------------------
 */

-- Create Trigger Function for set timestamp
CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.modified_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create Trigger Function for version increments
CREATE OR REPLACE function trigger_increment_version()
RETURNS TRIGGER as $$
BEGIN
  NEW.version := NEW.version + 1;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


/*
 * --------------------
 * Triggers
 * --------------------
 */

 -- Create modified-date trigger for public.users
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON public.users
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

-- Create modified-date trigger for public.seasons
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON public.seasons 
FOR EACH ROW 
EXECUTE PROCEDURE trigger_set_timestamp();

-- Create modified-date trigger for public.players
CREATE TRIGGER set_timestamp 
BEFORE UPDATE ON public.players
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

-- Create modified-date trigger for public.seasons_players
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON public.users_seasons
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

-- Create modified-date trigger for public.seasons_players
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON public.seasons_players
FOR EACH ROW EXECUTE
PROCEDURE trigger_set_timestamp();

-- Create modified-date trigger for public.games
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON public.games
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

-- Create increment-version trigger for public.users
CREATE TRIGGER increment_version
BEFORE UPDATE ON public.users
FOR EACH ROW
EXECUTE PROCEDURE trigger_increment_version();

-- Create increment-version trigger for public.seasons
CREATE TRIGGER increment_version
BEFORE UPDATE ON public.seasons
FOR EACH ROW
EXECUTE PROCEDURE trigger_increment_version();

-- Create increment-version trigger for public.players
CREATE TRIGGER increment_version
BEFORE UPDATE ON public.players
FOR EACH ROW
EXECUTE PROCEDURE trigger_increment_version();

-- Create increment-version trigger for public.users_seasons
CREATE TRIGGER increment_version
BEFORE UPDATE ON public.users_seasons
FOR EACH ROW
EXECUTE PROCEDURE trigger_increment_version();

-- Create increment-version trigger for public.seasons_players
CREATE TRIGGER increment_version
BEFORE UPDATE ON public.seasons_players
FOR EACH ROW
EXECUTE PROCEDURE trigger_increment_version();

-- Create increment-version trigger for public.games
CREATE TRIGGER increment_version
BEFORE UPDATE ON public.games
FOR EACH ROW
EXECUTE PROCEDURE trigger_increment_version();


/*
 * --------------------
 * Indexes
 * --------------------
 */
