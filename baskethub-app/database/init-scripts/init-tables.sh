#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
CREATE TABLE IF NOT EXISTS league
(
  id          int     NOT NULL GENERATED ALWAYS AS IDENTITY,
  external_id varchar,
  code        varchar NOT NULL UNIQUE,
  name        varchar NOT NULL UNIQUE,
  logo_url    varchar,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS season
(
  id         int     NOT NULL GENERATED ALWAYS AS IDENTITY,
  label      varchar NOT NULL,
  date_start date   ,
  date_end   date   ,
  league_id  int     NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS season_type
(
  id    int     NOT NULL GENERATED ALWAYS AS IDENTITY,
  code  varchar NOT NULL,
  name  varchar NOT NULL,
  group_name varchar NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS player
(
  id          int     NOT NULL GENERATED ALWAYS AS IDENTITY,
  external_id varchar,
  name        varchar  NOT NULL,
  country     varchar,
  height      int    ,
  weight      int    ,
  position    varchar,
  pts         float4 ,
  ast         float4 ,
  reb         float4 ,
  pie         float4 ,
  photo_url   varchar,
  team_id     int     NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS team
(
  id                int     NOT NULL GENERATED ALWAYS AS IDENTITY,
  external_id       varchar,
  name              varchar NOT NULL,
  nickname          varchar,
  abbreviation      varchar,
  conference        varchar,
  division          varchar,
  head_coach        varchar,
  city              varchar,
  arena             varchar,
  year_founded      int    ,
  year_active_until int    ,
  logo_url          varchar,
  league_id         int     NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS team_season_stats
(
  team_id         int    NOT NULL,
  season_id       int    NOT NULL,
  gp              int   ,
  win             int   ,
  loss            int   ,
  win_pct         float4,
  min             int   ,
  off_rating      float4,
  def_rating      float4,
  net_rating      float4,
  pace            float4,
  ast_pct         float4,
  oreb_pct        float4,
  dreb_pct        float4,
  reb_pct         float4,
  tov_pct         float4,
  gp_rank         int   ,
  win_rank        int   ,
  loss_rank       int   ,
  win_pct_rank    int   ,
  min_rank        int   ,
  off_rating_rank int   ,
  def_rating_rank int   ,
  net_rating_rank int   ,
  pace_rank       int   ,
  ast_pct_rank    int   ,
  oreb_pct_rank   int   ,
  dreb_pct_rank   int   ,
  reb_pct_rank    int   ,
  tov_pct_rank    int   ,
  PRIMARY KEY (team_id, season_id)
);

CREATE TABLE IF NOT EXISTS game
(
  id             int     NOT NULL GENERATED ALWAYS AS IDENTITY,
  external_id    varchar,
  date           date    NOT NULL,
  min            int    ,
  overtime_count int     DEFAULT 0,
  arena          varchar,
  season_id      int     NOT NULL,
  season_type_id int     NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS game_team
(
  id      int     NOT NULL GENERATED ALWAYS AS IDENTITY,
  game_id int     NOT NULL,
  team_id int     NOT NULL,
  is_home boolean,
  outcome varchar,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS game_team_stats
(
  game_team_id int    NOT NULL,
  period       int    NOT NULL,
  period_time  int    NOT NULL,
  pts          int   ,
  fgm          int   ,
  fga          int   ,
  fg_pct       float4,
  fg3m         int   ,
  fg3a         int   ,
  fg3_pct      float4,
  fg2m         int   ,
  fg2a         int   ,
  fg2_pct      float4,
  ftm          int   ,
  fta          int   ,
  ft_pct       float4,
  oreb         int   ,
  dreb         int   ,
  reb          int   ,
  ast          int   ,
  stl          int   ,
  blk          int   ,
  tov          int   ,
  pf           int   ,
  plus_minus   int   ,
  PRIMARY KEY (game_team_id, period, period_time)
);

ALTER TABLE season
  ADD CONSTRAINT FK_league_TO_season
    FOREIGN KEY (league_id)
    REFERENCES league (id);

ALTER TABLE team
  ADD CONSTRAINT FK_league_TO_team
    FOREIGN KEY (league_id)
    REFERENCES league (id);

ALTER TABLE player
  ADD CONSTRAINT FK_team_TO_player
    FOREIGN KEY (team_id)
    REFERENCES team (id);

ALTER TABLE game
  ADD CONSTRAINT FK_season_TO_game
    FOREIGN KEY (season_id)
    REFERENCES season (id);

ALTER TABLE game
  ADD CONSTRAINT FK_season_type_TO_game
    FOREIGN KEY (season_type_id)
    REFERENCES season_type (id);

ALTER TABLE team_season_stats
  ADD CONSTRAINT FK_team_TO_team_season_stats
    FOREIGN KEY (team_id)
    REFERENCES team (id);

ALTER TABLE game_team
  ADD CONSTRAINT FK_game_TO_game_team
    FOREIGN KEY (game_id)
    REFERENCES game (id);

ALTER TABLE team_season_stats
  ADD CONSTRAINT FK_season_TO_team_season_stats
    FOREIGN KEY (season_id)
    REFERENCES season (id);

ALTER TABLE game_team
  ADD CONSTRAINT FK_team_TO_game_team
    FOREIGN KEY (team_id)
    REFERENCES team (id);

ALTER TABLE game_team_stats
  ADD CONSTRAINT FK_game_team_TO_game_team_stats
    FOREIGN KEY (game_team_id)
    REFERENCES game_team (id);
EOSQL