extends Node2D

var steps_reducers = []

func add_steps_reducer(reducer: StepsHandler):
	steps_reducers.push_back(reducer)
	
func remove_steps_reducer(reducer: StepsHandler):
	steps_reducers.erase(reducer) 
	
func register_step(reducer: StepsHandler):
	var idx = steps_reducers.find(reducer)
	steps_reducers[idx].steps += 1
	
	for el_idx in steps_reducers.size():
		if el_idx != idx:
			var el_idle = steps_reducers[el_idx].idle
			var el_steps = steps_reducers[el_idx].steps
			if el_idle == 0 and el_steps != 0:
				# Go away
				print("go away")
				steps_reducers[el_idx].steps -= 1
				steps_reducers[el_idx].go_away.call()
			if el_idle > 0:
				steps_reducers[el_idx].idle -= 1
	
func register_stop(reducer: StepsHandler):
	var idx = steps_reducers.find(reducer)
	steps_reducers[idx].is_on_idle_place = false
	# Handle when on idle place
	
