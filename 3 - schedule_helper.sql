-- tired view
create or replace view tired as
with team_games as
(select distinct
	sub.*
from
(select 
	str_to_date(ts.Date,'%d/%m/%Y') as game_date,
	Home as team
from
	team_schedule ts
union all
select 
	str_to_date(ts.Date,'%d/%m/%Y') as game_date,
	Visiting as team
from
	team_schedule ts) sub)
select
    tg.game_date,
    tg.team,
    case when tg_yesterday.game_date is not null then 'Y' else 'N' end as tired
from
    team_games tg
    left outer join team_games tg_yesterday on tg.game_date-1 = tg_yesterday.game_date and tg.team = tg_yesterday.team
order by 1,2;


-- streaming and schedule view
with schedule_helper as
(select
    dates.day_date,
    dates.matchup,
    teams.team,
    games.opposition,
    games.location,
    case when games.team is null then null when offnights.matches <= 8 then 'Y' else 'N' end as off_night,
    tired_team.tired as tired_team,
    tired_opposition.tired as tired_opposition,
    case when games.team is null then null when tired_team.tired = 'Y' and tired_opposition.tired = 'Y' then 'Y' else 'N' end tired_both 
from
    dates
    inner join (select distinct Home as team from team_schedule) as teams on 1=1
    left outer join 
        (select
            str_to_date(ts.Date,'%d/%m/%Y') as game_date,
            ts.Home as team,
            ts.Visiting opposition,
            'Home' as location
        from 
            team_schedule ts
        union all 
        select
            str_to_date(ts.Date,'%d/%m/%Y') as game_date,
            ts.Visiting as team,
            ts.Home opposition,
            'Away' as location
        from 
            team_schedule ts) games on games.game_date = dates.day_date and games.team = teams.team
    left outer join
        (select
            str_to_date(ts.Date,'%d/%m/%Y') as game_date,
            count(Home) as matches
        from 
            team_schedule ts
        group by
            str_to_date(ts.Date,'%d/%m/%Y')) offnights on offnights.game_date = dates.day_date
    left outer join tired tired_team on tired_team.game_date = dates.day_date and tired_team.team = games.team
    left outer join tired tired_opposition on tired_opposition.game_date = dates.day_date and tired_opposition.team = games.opposition
)
select
	sh.day_date,
	sh.matchup,
	sh.team,
	sh.opposition,
	sh.location,
	sh.off_night,
	case when sh.tired_both = 'Y' then 'Both Tired' 
		when sh.tired_team = 'Y' then 'Tired' 
		when sh.tired_opposition = 'Y' then 'Tired Opposition' end as tired,
	summary.total_games,
	summary.off_nights,
	case when week_info.most_games = summary.total_games then 'Most Games'
		 when week_info.least_games = summary.total_games then 'Least Games' else null end as week_info,
	next_matchup.total_games as games_next_matchup,
	next_matchup.off_nights as off_nights_next_matchup
from
	schedule_helper sh
	left outer join
		(select
			matchup,
			team,
			count(opposition) as total_games,
			sum(case when off_night = 'Y' then 1 else 0 end) as off_nights
		from 
			schedule_helper
		group by
			matchup,
			team) summary on summary.matchup = sh.matchup and summary.team = sh.team
	left outer join
		(select
			matchup,
			team,
			count(opposition) as total_games,
			sum(case when off_night = 'Y' then 1 else 0 end) as off_nights
		from 
			schedule_helper
		group by
			matchup,
			team) next_matchup on next_matchup.matchup = sh.matchup+1 and next_matchup.team = sh.team
	left outer join
		(select
			matchup,
			min(total_games) as least_games,
			max(total_games) as most_games
		from
			(select
				matchup,
				team,
				count(opposition) as total_games,
				sum(case when off_night = 'Y' then 1 else 0 end) as off_nights
			from 
				schedule_helper
			group by
				matchup,
				team) sub 
		group by 
			matchup) week_info on week_info.matchup = sh.matchup
order by
	sh.day_date,
	sh.team
;
