-- Users
INSERT INTO public.users (name, username, password, salt, role) 
  VALUES (
    'User First',
    'firstuser',
    '32cb82d360ffd5e5c2939ec68beaf405923037b8c94fe0d75461c12d035cfa9d',
    'fbfeeeb5af9082a6c119b6f1a5403f8b',
    'SU_ADMIN');

INSERT INTO public.users (name, username, password, salt)
VALUES
  (
    'User Second',
    'seconduser',
    '1f669b8a1cbbc3d0f7ed215f5718631cb95cf0af5db52cffe8cdfc6721be3118',
    'f4cce197744de8ca5823dd073661ed40'
  );
COMMIT;

-- Seasons
INSERT INTO public.seasons (name, event_date, location)
VALUES
  (
    'Season 01',
    '2020-04-02 14:18:21.553273+00',
    'The Bar'
  );

INSERT INTO public.seasons (name, event_date, location)
VALUES
  (
    'Season 02',
    '2020-06-02 08:10:21.553273+00',
    'The Bar 2.0'
  );
INSERT INTO public.seasons (name, event_date, location)
VALUES
  (
    'Season 03',
    '2019-06-02 08:10:21.553273+00',
    'The Bar 3.0'
  );
COMMIT;

-- Users-Seasons
INSERT INTO public.users_seasons (user_id, season_id)
VALUES
  (1, 1);
  INSERT INTO public.users_seasons (user_id, season_id)
VALUES
  (1, 2);
INSERT INTO public.users_seasons (user_id, season_id)
VALUES
  (2, 3);
COMMIT;

-- Players
INSERT INTO public.players (name, user_id) VALUES ('Player One', 1);
INSERT INTO public.players (name, user_id) VALUES ('Player Two', 1);
INSERT INTO public.players (name, user_id) VALUES ('Player Three', 2);
INSERT INTO public.players (name, user_id) VALUES ('Player Four', 2);
COMMIT;

-- seasons-players
INSERT INTO public.seasons_players (season_id, player_id) VALUES (1, 1);
INSERT INTO public.seasons_players (season_id, player_id) VALUES (1, 2);
INSERT INTO public.seasons_players (season_id, player_id) VALUES (1, 3);
INSERT INTO public.seasons_players (season_id, player_id) VALUES (2, 4);
COMMIT;

-- Games
INSERT INTO public.games (
    season_id,
    user_id,
    player_home_id,
    player_home_goals,
    player_away_id,
    player_away_goals
  )
VALUES
  (1, 1, 1, 5, 2, 3);

INSERT INTO public.games (
    season_id,
    user_id,
    player_home_id,
    player_home_goals,
    player_away_id,
    player_away_goals
  )
VALUES
  (1, 1, 2, 1, 3, 0);

INSERT INTO public.games (
    season_id,
    user_id,
    player_home_id,
    player_home_goals,
    player_away_id,
    player_away_goals
  )
VALUES
  (1, 1, 1, 3, 3, 2);

INSERT INTO public.games (
    season_id,
    user_id,
    player_home_id,
    player_home_goals,
    player_away_id,
    player_away_goals
  )
VALUES
  (2, 1, 1, 3, 3, 2);

INSERT INTO public.games (
    season_id,
    user_id,
    player_home_id,
    player_home_goals,
    player_away_id,
    player_away_goals
  )
VALUES
  (3, 2, 1, 3, 3, 2);
COMMIT;
