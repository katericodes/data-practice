-- 1. What are the names of the players whose salary is greater than 100,000?
select player_name, salary
from Players
where salary > 100000

-- 2. What is the team name of the player with player_id = 3?
select team_name, player_name, player_id
from Players join Teams on Players.team_id = Teams.team_id
where player_id = 3

-- 3. What is the total number of players in each team?
select team_name, count (team_name) as "# of players"
from Players join Teams on Players.team_id = Teams.team_id
group by team_name

-- 4. What is the team name and captain name of the team with team_id = 2?
select team_name, player_name
from Teams join Players on Teams.team_id = Players.team_id
where captain_id = player_id and Teams.team_id = 2

-- This is assuming the captain_id follows the same id system as the player_id

-- 5. What are the player names and their roles in the team with team_id = 1?
select team_name, player_name, role
from Teams join Players on Teams.team_id = Players.team_id
where Teams.team_id = 1

-- 6. What are the team names and the number of matches they have won?
select team_name, count(winner_id) as "matches won"
from Matches join Teams on Matches.winner_id = Teams.team_id
group by winner_id

-- 7. What is the average salary of players in the teams with country 'USA'?
select team_name, round(avg(salary),2)
from Teams join Players on Teams.team_id = Players.team_id
where country = "USA"
group by team_name

-- 8. Which team won the most matches?
select team_name, count(winner_id) as "matches won"
from Matches join Teams on Matches.winner_id = Teams.team_id
group by winner_id
order by count(winner_id) desc
limit 1

-- 9. What are the team names and the number of players in each team whose salary is greater than 100,000?
select team_name, count(player_id) as "# of players with salary > $100,000)", avg(salary) as "average salary"
from Teams join Players on Teams.team_id = Players.team_id
where Players.salary > 100000
group by team_name

-- 10. What is the date and the score of the match with match_id = 3?
select match_date, concat(score_team1, " to ", score_team2) as match_score
from Matches
where match_id = 3