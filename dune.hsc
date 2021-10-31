;Useful: less lethal phantom variant is "long_lift" | units might plunge to their deaths otherwise

(global short wave 1) ;Firefight starts with value of 1
(global short rand_wv 0) ;For that refreshing replayable flavor

;=========================
;Phantom Unload Scripts
;=========================

;Unique unload for each phantom used. "phantom_p_<a><b><c>" unloads in trios
(script static void phantom_1_unload
	(object_set_phantom_power (ai_vehicle_get_from_starting_location phantom_1/pilot) TRUE)
	(vehicle_unload (ai_vehicle_get_from_starting_location phantom_1/pilot) "phantom_p_a")
	(sleep 30)
	(vehicle_unload (ai_vehicle_get_from_starting_location phantom_1/pilot) "phantom_p_b")
	(sleep 30)
	(vehicle_unload (ai_vehicle_get_from_starting_location phantom_1/pilot) "phantom_p_c")
	(sleep 90)
	(object_set_phantom_power (ai_vehicle_get_from_starting_location phantom_1/pilot) FALSE)
)

;All scripts are identical here
(script static void phantom_2_unload
	(object_set_phantom_power (ai_vehicle_get_from_starting_location phantom_2/pilot) TRUE)
	(vehicle_unload (ai_vehicle_get_from_starting_location phantom_2/pilot) "phantom_p_a")
	(sleep 30)
	(vehicle_unload (ai_vehicle_get_from_starting_location phantom_2/pilot) "phantom_p_b")
	(sleep 30)
	(vehicle_unload (ai_vehicle_get_from_starting_location phantom_2/pilot) "phantom_p_c")
	(sleep 90)
	(object_set_phantom_power (ai_vehicle_get_from_starting_location phantom_2/pilot) FALSE)
)

(script static void phantom_3_unload
	(object_set_phantom_power (ai_vehicle_get_from_starting_location phantom_3/pilot) TRUE)
	(vehicle_unload (ai_vehicle_get_from_starting_location phantom_3/pilot) "phantom_p_a")
	(sleep 30)
	(vehicle_unload (ai_vehicle_get_from_starting_location phantom_3/pilot) "phantom_p_b")
	(sleep 30)
	(vehicle_unload (ai_vehicle_get_from_starting_location phantom_3/pilot) "phantom_p_c")
	(sleep 90)
	(object_set_phantom_power (ai_vehicle_get_from_starting_location phantom_3/pilot) FALSE)
)

(script static void phantom_4_unload
	(object_set_phantom_power (ai_vehicle_get_from_starting_location phantom_4/pilot) TRUE)
	(vehicle_unload (ai_vehicle_get_from_starting_location phantom_4/pilot) "phantom_p_a")
	(sleep 30)
	(vehicle_unload (ai_vehicle_get_from_starting_location phantom_4/pilot) "phantom_p_b")
	(sleep 30)
	(vehicle_unload (ai_vehicle_get_from_starting_location phantom_4/pilot) "phantom_p_c")
	(sleep 90)
	(object_set_phantom_power (ai_vehicle_get_from_starting_location phantom_4/pilot) FALSE)
)

;=========================
;Wave 1
;=========================

;Command scripts are assigned directly to AI units to manually control their behavior
(script command_script phantom_1_scts
	(print "Phantom 1 cs running")

	;Sleep for one tick (just in case random_range results are tick-dependent - might be unnecessary)
	(sleep 1)
	(set rand_wv (random_range 0 2)) ;Range max must be one above last squad case
	(if (= rand_wv 0) ;If statements can only run one expression. Use begin to run a block of code as a single expression
		(begin
			(print "Routine 1") ;For testing purposes
			(ai_place jackal_scouts (random_range 2 3)) ;Place ai. REMEMBER: phantom can only seat nine passengers at once
			(ai_place grunt_scouts (random_range 5 6))  ;You may be able to add more by placing more AI after phantom has unloaded
														;then running the unload command script again
			;Instantly load troops into the vehicle spawned in squad "phantom_1" at staring location "pilot"
			(vehicle_load_magic (ai_vehicle_get_from_starting_location phantom_1/pilot) "phantom_p" (ai_actors jackal_scouts))
			(vehicle_load_magic (ai_vehicle_get_from_starting_location phantom_1/pilot) "phantom_p" (ai_actors grunt_scouts))
			(vehicle_load_magic (ai_vehicle_get_from_starting_location phantom_1/pilot) "phantom_p" (ai_actors grunt_scouts))
		)
	)
	;Second spawn variation. Add as many as you like, increasing the rand_wv range as you do
	(if (= rand_wv 1)
		(begin
			(print "Routine 2")
			(ai_place grunt_scouts (random_range 7 9))
			(vehicle_load_magic (ai_vehicle_get_from_starting_location phantom_1/pilot) "phantom_p" (ai_actors grunt_scouts))
			(vehicle_load_magic (ai_vehicle_get_from_starting_location phantom_1/pilot) "phantom_p" (ai_actors grunt_scouts))
			(vehicle_load_magic (ai_vehicle_get_from_starting_location phantom_1/pilot) "phantom_p" (ai_actors grunt_scouts))
		)
	)

	(cs_enable_pathfinding_failsafe TRUE) ;This command prevents phantoms from bugging in place
	(cs_fly_by phantom_flyin_1/p0) ;Fly by a point in point set "phantom_flying_1" | Point sets located at AI/Script data/Point sets
								   ;Can fly by and to as many points as you like, even deploying troops in multiple locations
	;If you want the phantom to slow as it approaches its destination
	;(cs_vehicle_speed .5)
	(cs_fly_to phantom_flyin_1/p1)

	(phantom_1_unload) ;Run the unload script...
	(sleep_until (< (ai_living_count phantom_1) 2)) ;Wait for all troops to disembark before leaving!

	(cs_fly_by phantom_flyout_1/p0) ;Same as before
	;with optional speed up!
	;(cs_vehicle_speed 1)
	(cs_fly_to phantom_flyout_1/p1)

	(ai_erase phantom_1) ;Erase the phantom once its route is complete. This is CRITICAL
)

;Same routine as above for a separate phantom
(script command_script phantom_2_scts
	(print "Phantom 2 cs running")

	(sleep 1)
	(set rand_wv (random_range 0 2))
	(if (= rand_wv 0)
		(begin
			(print "Routine 1")
			(ai_place jackal_scouts)
			(ai_place grunt_scouts)
			(vehicle_load_magic (ai_vehicle_get_from_starting_location phantom_2/pilot) "phantom_p" (ai_actors jackal_scouts))
			(vehicle_load_magic (ai_vehicle_get_from_starting_location phantom_2/pilot) "phantom_p" (ai_actors grunt_scouts))
			(vehicle_load_magic (ai_vehicle_get_from_starting_location phantom_2/pilot) "phantom_p" (ai_actors grunt_scouts))
		)
	)
	(if (= rand_wv 1)
		(begin
			(print "Routine 2")
			(ai_place elite_scouts (random_range 1 2))
			(ai_place jackal_scouts 3)
			(ai_place grunt_scouts 3)
			(vehicle_load_magic (ai_vehicle_get_from_starting_location phantom_2/pilot) "phantom_p" (ai_actors elite_scouts))
			(vehicle_load_magic (ai_vehicle_get_from_starting_location phantom_2/pilot) "phantom_p" (ai_actors jackal_scouts))
			(vehicle_load_magic (ai_vehicle_get_from_starting_location phantom_2/pilot) "phantom_p" (ai_actors grunt_scouts))
		)
	)

	(cs_enable_pathfinding_failsafe TRUE)
	(cs_fly_by phantom_flyin_2/p0)
	;(cs_vehicle_speed .5)
	(cs_fly_to phantom_flyin_2/p1)

	(phantom_2_unload)
	(sleep_until (< (ai_living_count phantom_2) 2))
	
	(cs_vehicle_speed 1)
	(cs_fly_by phantom_flyout_2/p0)
	(cs_fly_to phantom_flyout_2/p1)

	(ai_erase phantom_2)
)

(script static void wave_1
	(print "Scouts") ;For testing
	(set wave 0) ;Setting wave to 0 prevents the continuous firefight script below from running the wave again. Use for every wave
	
	;Place phantoms...
	(ai_place phantom_1 1)
	(ai_place phantom_2 1)
	;Then run their respective command scripts
	(cs_run_command_script phantom_1 phantom_1_scts)
	(cs_run_command_script phantom_2 phantom_2_scts)
	(sleep 90) ;For good measure

	;Wait until all phantoms have departed and all squads in the "wv1" squad group are dead
	(sleep_until 
		(and
			(< (ai_living_count all_phantoms) 1)
			(< (ai_living_count wv1) 1)
		)
	)
	(set wave 2)
	(print "Scouts Neutralized. Reinforcements...")
	(sleep 60)
)

;=========================
;Wave 2
;=========================

;Structure of all waves is identical here
(script command_script phantom_3_wv2
	(sleep 1)
	(set rand_wv (random_range 0 2))
	(if (= rand_wv 0)
		(begin
			(print "Routine 1")
			(ai_place wv2_elites 3)
			(ai_place wv2_grunts (random_range 5 6))
			(vehicle_load_magic (ai_vehicle_get_from_starting_location phantom_3/pilot) "phantom_p" (ai_actors wv2_elites))
			(vehicle_load_magic (ai_vehicle_get_from_starting_location phantom_3/pilot) "phantom_p" (ai_actors wv2_grunts))
			(vehicle_load_magic (ai_vehicle_get_from_starting_location phantom_3/pilot) "phantom_p" (ai_actors wv2_grunts))
		)
	)
	(if (= rand_wv 1)
		(begin
			(print "Routine 2")
			(ai_place wv2_elites (random_range 2 4))
			(ai_place wv2_jackals (random_range 4 5))
			(vehicle_load_magic (ai_vehicle_get_from_starting_location phantom_3/pilot) "phantom_p" (ai_actors wv2_elites))
			(vehicle_load_magic (ai_vehicle_get_from_starting_location phantom_3/pilot) "phantom_p" (ai_actors wv2_jackals))
		)
	)

	(cs_enable_pathfinding_failsafe TRUE)
	(cs_fly_by phantom_flyin_3/p0)
	;(cs_vehicle_speed .5)
	(cs_fly_to phantom_flyin_3/p1)

	(phantom_3_unload)
	(sleep_until (< (ai_living_count phantom_3) 2))
	
	(cs_vehicle_speed 1)
	(cs_fly_by phantom_flyout_3/p0)
	(cs_fly_to phantom_flyout_3/p1)

	(ai_erase phantom_3)
)

(script command_script phantom_2_wv2
	(sleep 1)
	(set rand_wv (random_range 0 2))
	(if (= rand_wv 0)
		(begin
			(print "Routine 1")
			(ai_place wv2_elites)
			(ai_place wv2_grunts)
			(vehicle_load_magic (ai_vehicle_get_from_starting_location phantom_2/pilot) "phantom_p" (ai_actors wv2_elites))
			(vehicle_load_magic (ai_vehicle_get_from_starting_location phantom_2/pilot) "phantom_p" (ai_actors wv2_grunts))
			(vehicle_load_magic (ai_vehicle_get_from_starting_location phantom_2/pilot) "phantom_p" (ai_actors wv2_grunts))
		)
	)
	(if (= rand_wv 1)
		(begin
			(print "Routine 2")
			(ai_place wv2_elites 3)
			(ai_place wv2_jackals_carb 3)
			(ai_place wv2_grunts 3)
			(vehicle_load_magic (ai_vehicle_get_from_starting_location phantom_2/pilot) "phantom_p" (ai_actors wv2_elites))
			(vehicle_load_magic (ai_vehicle_get_from_starting_location phantom_2/pilot) "phantom_p" (ai_actors wv2_jackals_carb))
			(vehicle_load_magic (ai_vehicle_get_from_starting_location phantom_2/pilot) "phantom_p" (ai_actors wv2_grunts))
		)
	)

	(cs_enable_pathfinding_failsafe TRUE)
	(cs_fly_by phantom_flyin_2/p0)
	;(cs_vehicle_speed .5)
	(cs_fly_to phantom_flyin_2/p1)

	(phantom_2_unload)
	(sleep_until (< (ai_living_count phantom_2) 2))
	
	(cs_vehicle_speed 1)
	(cs_fly_by phantom_flyout_2/p0)
	(cs_fly_to phantom_flyout_2/p1)

	(ai_erase phantom_2)
)

(script static void wave_2
	(print "Wave 2")
	(set wave 0)
	
	(ai_place phantom_3)
	(ai_place phantom_2)
	(cs_run_command_script phantom_3 phantom_3_wv2)
	(cs_run_command_script phantom_2 phantom_2_wv2)

	(sleep_until 
		(and
			(< (ai_living_count all_phantoms) 1)
			(< (ai_living_count wv2) 1)
		)
	)
	(set wave 3)
	(print "Reinforcements NEUTRALIZED")
	(sleep 90)
)

;=========================
;Wave 3
;=========================

(script command_script phantom_4_wv3
	(sleep 1)
	(set rand_wv 1) ;Not random here because there's only one squad
	(if (= rand_wv 1)
		(begin
			(print "Hunters")
			(ai_place wv3_hunters)
			(vehicle_load_magic (ai_vehicle_get_from_starting_location phantom_4/pilot) "phantom_p" (ai_actors wv3_hunters))
		)
	)

	(cs_enable_pathfinding_failsafe TRUE)
	(cs_fly_by phantom_flyin_4/p0)
	;(cs_vehicle_speed .5)
	(cs_fly_to phantom_flyin_4/p1)

	(phantom_4_unload)
	(sleep_until (< (ai_living_count phantom_4) 2))
	
	(cs_vehicle_speed 1)
	(cs_fly_by phantom_flyout_4/p0)
	(cs_fly_to phantom_flyout_4/p1)

	(ai_erase phantom_4)
)

(script static void wave_3
	(print "Wave 3")
	(set wave 0)
	
	(ai_place phantom_4)
	(cs_run_command_script phantom_4 phantom_4_wv3)

	(sleep_until 
		(and
			(< (ai_living_count all_phantoms) 1)
			(< (ai_living_count wv3) 1)
		)
	)
	(set wave 1) ;Reset wave to first so it loops forever
	(print "Reinforcements Dead. Looping...")
	(sleep 90)
)

;================================================================================================
;Mission Scripts
;================================================================================================

;Deploying from a separate script keeps things clean
(script static void deploy
	(if (= wave 1)
		(wave_1)
	)
	(if (= wave 2)
		(wave_2)
	)
	(if (= wave 3)
		(wave_3)
	)
)

(script continuous firefight
	(if (< (ai_living_count all_phantoms) 1) ;Always waiting to deploy next wave as soon as all phantoms have departed
		(deploy)
	)
)

(script static void setup
	;Phantom fire is obnoxious. Phantoms are now double agents
	(ai_allegiance covenant unused8)
	(ai_allegiance player unused8)
)

(script startup dune_firefight
	;Campaign will force fade out on startup. Lazily counter it with this
	(fade_in 1 1 1 15)
	(setup) ;Important initial stuff
)
