-- write your table creation sql here!

DROP TABLE IF EXISTS baseball_data;

CREATE TABLE baseball_data(


	year INTEGER PRIMARY KEY,


	teams SMALLINT,


	batters INTEGER,


	avg_batter_age NUMERIC(3, 1),


	runs_per_game NUMERIC(4, 2),


	games INTEGER,


	plate_appearances NUMERIC(4, 2),


	at_bats NUMERIC(4, 2),


	hits_per_game NUMERIC(4, 2),


	doubles_per_game NUMERIC(3, 2),


	triples_per_game NUMERIC(3, 2),


	homeruns_per_game NUMERIC(3, 2),


	runs_batted_in NUMERIC(3, 2),


	stolen_bases_avg NUMERIC(3, 2),


	caught_stealing_avg NUMERIC(3, 2),


	walks_per_game NUMERIC(3, 2),


	strikeouts_per_game NUMERIC(3, 2),


	batting_avg NUMERIC(3, 3),


	on_base_percentage NUMERIC(3, 3),


	slugging NUMERIC(3, 3),


	on_base_slugging NUMERIC(3, 3),


	total_bases NUMERIC(4, 2),


	double_plays NUMERIC(3, 2),


	hit_by_pitch NUMERIC(3, 2),


	sacrifice_bunts NUMERIC(3, 2),


	sacrifice_flies NUMERIC(3, 2),


	intentional_walks NUMERIC(3, 2)


);