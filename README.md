# Dev Commands

## BasketHub

up
```bash
docker compose -f baskethub-app/docker-compose.yaml up --build -d
```

down
```bash
docker compose -f baskethub-app/docker-compose.yaml down -v
```

start
```bash
docker compose -f baskethub-app/docker-compose.yaml start
```

stop
```bash
docker compose -f baskethub-app/docker-compose.yaml stop
```

---
## Airflow

up
```bash
docker compose -f baskethub-airflow/docker-compose.yaml up --build -d
```

down
```bash
docker compose -f baskethub-airflow/docker-compose.yaml down -v
```

start
```bash
docker compose -f baskethub-airflow/docker-compose.yaml start
```

stop
```bash
docker compose -f baskethub-airflow/docker-compose.yaml stop
```


# Data Model

The data model includes the following tables:

<details>
<summary><strong>league</strong> - information about basketball leagues: NBA, WNBA, etc.</summary>
<br/>

| Field                         | Description                                                           | Data Sample           |
| ----------------------------- |-----------------------------------------------------------------------|-----------------------|
| external_id                   | external code received from the source system                         | 00                    |
| code                          | internal code used to run the application                             | nba                   |
| name                          | league readable name                                                  | NBA                   |
| logo_url                      | path to S3 containing the logo image                                  | /logos/nba/league.png |
</details>

<details>
<summary><strong>season</strong> - season data for each league</summary>
<br/>

| Field                         | Description                                                           | Data Sample           |
| ----------------------------- |-----------------------------------------------------------------------|-----------------------|
| label                         | label of season, in format: yyyy-yy                                   | 2024-25               |
| date_start                    | start date of season                                                  | 2024-09-01            |
| date_end                      | end date of season                                                    | 2025-05-30            |
</details>

<details>
<summary><strong>season_type</strong> - type of season: Regular, Playoffs, etc.</summary>
<br/>

| Field                         | Description                                                           | Data Sample           |
| ----------------------------- |-----------------------------------------------------------------------|-----------------------|
| code                          | internal code used to run the application                             | in_season             |
| name                          | season type readable name                                             | In-Season Tournament  |
| group_name                    | a group into which different types of seasons are grouped to enhance the analysis capabilities; Regular Season, In-Season Tournament -> Regular Season | Regular Season        |
</details>

<details>
<summary><strong>team</strong> - list of teams and up-to-date information about them</summary>
<br/>

| Field                         | Description                                                            | Data Sample              |
| ----------------------------- |------------------------------------------------------------------------|--------------------------|
| external_id                   | external code received from the source system                          | 1610612742               |
| name                          | team readable name                                                     | Dallas Mavericks         |
| nickname                      | team short, readable name                                              | Mavericks                |
| abbreviation                  | team abbreviation                                                      | DAL                      |
| conference                    | team conference                                                        | East                     |
| division                      | team division                                                          | Atlantic                 |
| city                          | team city                                                              | Dallas                   |
| arena                         | team arena                                                             | American Airlines Center |
| year_founded                  | team year of foundation                                                | 1960                     |
| year_active_until             | year up to which the team existed; if the team still exists, then NULL | 1990                     |
| logo_url                      | path to S3 containing the logo image                                   | /logos/nba/team/dal.png  |
</details>

<details>
<summary><strong>team_season_stats</strong> - team statistics for each season</summary>
<br/>

| Field                         | Description                                                           | Data Sample           |
| ----------------------------- |-----------------------------------------------------------------------|-----------------------|
| gp                            | number of games playes                                                | 82                    |
| win                           | number of games won                                                   | 47                    |
| loss                          | number of game lost                                                   | 35                    |
| win_pct                       | winning percentage                                                    | 0.573                 |
| min                           | number of minutes played                                              | 3941                  |
| off_rating                    | offensive rating                                                      | 117.9                 |
| def_rating                    | defensive rating                                                      | 115.5                 |
| net_rating                    | difference between the offensive rating and the defensive rating      | 2.5                   |
| pace                          | number of possessions a team gets per game                            | 104.2                 |
| ast_ratio                     | assist ratio                                                          | 21                    |
| oreb_pct                      | offensive rebound percentage                                          | 0.238                 |
| dreb_pct                      | defensive rebound percentage                                          | 0.741                 |
| reb_pct                       | rebound percentage                                                    | 0.489                 |
| tov_pct                       | turnover percentage                                                   | 0.124                 |
| gp_rank                       | rank by number of games played                                        | 1                     |
| win_rank                      | rank by number of games won                                           | 12                    |
| loss_rank                     | rank by number of games lost                                          | 12                    |
| win_pct_rank                  | rank by winning percentage                                            | 12                    |
| min_rank                      | rank by number of minutes played                                      | 26                    |
| off_rating_rank               | rank by offensive rating                                              | 2                     |
| def_rating_rank               | rank by defensive rating                                              | 24                    |
| net_rating_rank               | rank by net rating                                                    | 13                    |
| pace_rank                     | rank by number of possessions a team gets per game                    | 2                     |
| ast_ratio_rank                | rank by assist ratio                                                  | 1                     |
| oreb_pct_rank                 | rank by offensive rebound percentage                                  | 20                    |
| dreb_pct_rank                 | rank by defensive rebound percentage                                  | 26                    |
| reb_pct_rank                  | rank by rebound percentage                                            | 24                    |
| tov_pct_rank                  | rank by turnover percentage                                           | 6                     |
</details>

<details>
<summary><strong>player</strong> - list of players and up-to-date information about them</summary>
<br/>

| Field                         | Description                                                           | Data Sample           |
| ----------------------------- |-----------------------------------------------------------------------|-----------------------|
| external_id                   | external code received from the source system                         | 1610612742            |
| name                          | player name                                                           | Luka Dončić           |
| country                       | player country of birth                                               | Slovenia              |
| height                        | player height in centimeters                                          | 198                   |
| weight                        | player weight in kilograms                                            | 104                   |
| position                      | player position                                                       | Point guard, Shooting guard |
| pts                           | career points average                                                 | 31.1                  |
| ast                           | career assists average                                                | 12.1                  |
| reb                           | career rebounds average                                               | 8.0                   |
| pie                           | player impact estimate                                                | 0.89                  |
| photo_url                     | path to S3 containing the player photo                                | /logos/nba/player/luka_doncic.png |
</details>

<details>
<summary><strong>game</strong> - list of completed games</summary>
<br/>

| Field                         | Description                                                           | Data Sample              |
| ----------------------------- |-----------------------------------------------------------------------|--------------------------|
| external_id                   | external code received from the source system                         | 1610612742               |
| date                          | start date of game                                                    | 2024-10-23               |
| min                           | game duration in minutes                                              | 240                      |
| overtime_count                | number of overtimes in the game (0 by default)                        | 1                        |
| arena                         | arena where the game is played                                        | American Airlines Center |
</details>

<details>
<summary><strong>game_team</strong> - additional info about the game for each participating team</summary>
<br/>

| Field                         | Description                                                           | Data Sample           |
| ----------------------------- |-----------------------------------------------------------------------|-----------------------|
| is_home                       | true - for home team; false - for road team                           | true                  |
| outcome                       | enum: win, loss                                                       | win                   |
</details>

<details>
<summary><strong>game_team_stats</strong> - statistics on completed games for each team</summary>
<br/>

| Field                         | Description                                                           | Data Sample           |
| ----------------------------- |-----------------------------------------------------------------------|-----------------------|
| period                        | number of the game period                                             | 2                     |
| period_time                   | number of game seconds, starting from 0                               | 100                   |
| pts                           | number of points scored                                               | 130                   |
| fgm                           | number of field goals made                                            | 50                    |
| fga                           | number of field goals attempts                                        | 70                    |
| fg_pct                        | field goal percentage                                                 | 0.714                 |
| fg3m                          | number of 3-point field goals mage                                    | 10                    |
| fg3a                          | number of 3-point field goal attempts                                 | 24                    |
| fg3_pct                       | 3-point field goal percentage                                         | 0.417                 |
| fg2m                          | number of 2-point field goals mage                                    | 40                    |
| fg2a                          | number of 2-point field goal attempts                                 | 46                    |
| fg2_pct                       | 2-point field goal percentage                                         | 0.869                 |
| ftm                           | number of free throws made                                            | 3                     |
| fta                           | number of free throw attempts                                         | 6                     |
| ft_pct                        | free throw percentage                                                 | 0.5                   |
| oreb                          | number of offensive rebounds                                          | 20                    |
| dreb                          | number of deffensive rebounds                                         | 14                    |
| reb                           | total number of rebounds                                              | 34                    |
| ast                           | total number of assists                                               | 17                    |
| stl                           | total number of steals                                                | 6                     |
| blk                           | total number of blocks                                                | 16                    |
| tov                           | total number of turnovers                                             | 3                     |
| pf                            | total number of personal fouls                                        | 18                    |
| plus_minus                    | point difference with the opposing team                               | -8                    |
</details>

<br/>

![Data Model - Core](/documentation/data_model.png)

<br/>

Useful links about calculating statistical measures:
- https://www.nbastuffer.com/
- https://captaincalculator.com/sports/basketball/