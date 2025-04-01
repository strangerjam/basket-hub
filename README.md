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

The data model defines two groups of tables: core tables and datamarts.

- **Core tables** are a set of normalized tables intended for operational work of the application.

- **Datamarts**, in turn, are a set of denormalized tables that provide the application with analytical data.

## Core tables

This table group contains the following tables:

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
| group                         | a group into which different types of seasons are grouped to enhance the analysis capabilities; Regular Season, In-Season Tournament -> Regular Season | Regular Season        |
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
| city                          | team city                                                              | Dallas                   |
| arena                         | team arena                                                             | American Airlines Center |
| year_founded                  | team year of foundation                                                | 1960                     |
| year_active_until             | year up to which the team existed; if the team still exists, then NULL | 1990                     |
| logo_url                      | path to S3 containing the logo image                                   | /logos/nba/team/dal.png  |
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
| pie                           | player impact estimate (https://www.nbastuffer.com/analytics101/player-impact-estimate-pie/) | 0.89                  |
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
| arena                         | arena where the game is played                                        | American Airlines Center |
</details>

<details>
<summary><strong>game_team_stats</strong> - statistics on completed games for each team</summary>
<br/>

| Field                         | Description                                                           | Data Sample           |
| ----------------------------- |-----------------------------------------------------------------------|-----------------------|
| is_home                       | true - for home team; false - for road team                           | true                  |
| outcome                       | enum: win, loss                                                       | win                   |
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

![Data Model - Core](/documentation/data_model-core.png)



## Datamarts
