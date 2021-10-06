-- create a dates dimension
create or replace table dates
	(day_date date,
	matchup int(11));

-- run the below procedure up to and including the END; line and then run call loop_date(); to populate the dates table
CREATE or replace PROCEDURE loop_date()
BEGIN
DECLARE date_var date DEFAULT str_to_date('12/10/2021','%d/%m/%Y'); 
WHILE (date_var < str_to_date('29/04/2022','%d/%m/%Y')) DO
    INSERT INTO dates (day_date, matchup) VALUES (date_var);
    set date_var = date_var + INTERVAL 1 DAY;
END WHILE;
END;

call loop_date();

update dates set matchup = 1 where day_date between str_to_date('12/10/2021','%d/%m/%Y') and str_to_date('17/10/2021','%d/%m/%Y');
update dates set matchup = 2 where day_date between str_to_date('18/10/2021','%d/%m/%Y') and str_to_date('24/10/2021','%d/%m/%Y');
update dates set matchup = 3 where day_date between str_to_date('25/10/2021','%d/%m/%Y') and str_to_date('31/10/2021','%d/%m/%Y');
update dates set matchup = 4 where day_date between str_to_date('01/11/2021','%d/%m/%Y') and str_to_date('07/11/2021','%d/%m/%Y');
update dates set matchup = 5 where day_date between str_to_date('08/11/2021','%d/%m/%Y') and str_to_date('14/11/2021','%d/%m/%Y');
update dates set matchup = 6 where day_date between str_to_date('15/11/2021','%d/%m/%Y') and str_to_date('21/11/2021','%d/%m/%Y');
update dates set matchup = 7 where day_date between str_to_date('22/11/2021','%d/%m/%Y') and str_to_date('28/11/2021','%d/%m/%Y');
update dates set matchup = 8 where day_date between str_to_date('29/11/2021','%d/%m/%Y') and str_to_date('05/12/2021','%d/%m/%Y');
update dates set matchup = 9 where day_date between str_to_date('06/12/2021','%d/%m/%Y') and str_to_date('12/12/2021','%d/%m/%Y');
update dates set matchup = 10 where day_date between str_to_date('13/12/2021','%d/%m/%Y') and str_to_date('19/12/2021','%d/%m/%Y');
update dates set matchup = 11 where day_date between str_to_date('20/12/2021','%d/%m/%Y') and str_to_date('02/01/2022','%d/%m/%Y');
update dates set matchup = 12 where day_date between str_to_date('03/01/2022','%d/%m/%Y') and str_to_date('09/01/2022','%d/%m/%Y');
update dates set matchup = 13 where day_date between str_to_date('10/01/2022','%d/%m/%Y') and str_to_date('16/01/2022','%d/%m/%Y');
update dates set matchup = 14 where day_date between str_to_date('17/01/2022','%d/%m/%Y') and str_to_date('23/01/2022','%d/%m/%Y');
update dates set matchup = 15 where day_date between str_to_date('24/01/2022','%d/%m/%Y') and str_to_date('30/01/2022','%d/%m/%Y');
update dates set matchup = 16 where day_date between str_to_date('31/01/2022','%d/%m/%Y') and str_to_date('27/02/2022','%d/%m/%Y');
update dates set matchup = 17 where day_date between str_to_date('28/02/2022','%d/%m/%Y') and str_to_date('06/03/2022','%d/%m/%Y');
update dates set matchup = 18 where day_date between str_to_date('07/03/2022','%d/%m/%Y') and str_to_date('13/03/2022','%d/%m/%Y');
update dates set matchup = 19 where day_date between str_to_date('14/03/2022','%d/%m/%Y') and str_to_date('20/03/2022','%d/%m/%Y');
update dates set matchup = 20 where day_date between str_to_date('21/03/2022','%d/%m/%Y') and str_to_date('27/03/2022','%d/%m/%Y');
update dates set matchup = 21 where day_date between str_to_date('28/03/2022','%d/%m/%Y') and str_to_date('03/04/2022','%d/%m/%Y');
update dates set matchup = 22 where day_date between str_to_date('04/04/2022','%d/%m/%Y') and str_to_date('10/04/2022','%d/%m/%Y');
update dates set matchup = 23 where day_date between str_to_date('11/04/2022','%d/%m/%Y') and str_to_date('17/04/2022','%d/%m/%Y');
update dates set matchup = 24 where day_date between str_to_date('18/04/2022','%d/%m/%Y') and str_to_date('29/04/2022','%d/%m/%Y');
commit;
