extends Node2D

onready var game_won = preload("res://GameWon.tscn")

onready var checker_dict = {
	"row_one":[0,1,2,3,4,5,6,7,8,9],
	"row_two":[10,11,12,13,14,15,16,17,18,19],
	"row_three":[20,21,22,23,24,25,26,27,28,29],
	"row_four":[30,31,32,33,34,35,36,37,38,39],
	"row_five":[40,41,42,43,44,45,46,47,48,49],
	"row_six":[50,51,52,53,54,55,56,57,58,59],
	"row_seven":[60,61,62,63,64,65,66,67,68,69],
	"row_eight":[70,71,72,73,74,75,76,77,78,79],
	"row_nine":[80,81,82,83,84,85,86,87,88,89],
	"row_ten":[90,91,92,93,94,95,96,97,98,99],
	"col_one" : [0,10,20,30,40,50,60,70,80,90],
	"col_two" : [1,11,21,31,41,51,61,71,81,91],
	"col_three" : [2,12,22,32,42,52,62,72,82,92],
	"col_four" : [3,13,23,33,43,53,63,73,83,93],
	"col_five" : [4,14,24,34,44,54,64,74,84,94],
	"col_six" : [5,15,25,35,45,55,65,75,85,95],
	"col_seven" : [6,16,26,36,46,56,66,76,86,96],
	"col_eight" : [7,17,27,37,47,57,67,77,87,97],
	"col_nine" : [8,18,28,38,48,58,68,78,88,98],
	"col_ten" : [9,19,29,39,49,59,69,79,89,99],
	"dia_one" : [50,61,72,83,94],
	"dia_two" : [40,51,62,73,84,95],
	"dia_three" : [30,41,52,63,74,85,96],
	"dia_four" : [20,31,42,53,64,75,86,97],
	"dia_five" : [10,21,32,43,54,65,76,87,98],
	"dia_six" : [0,11,22,33,44,55,66,77,88,99],
	"dia_seven" : [1,12,23,34,45,56,67,78,89],
	"dia_eight" : [2,13,24,35,46,57,68,79],
	"dia_nine" : [3,14,25,36,47,58,69],
	"dia_ten" : [4,15,26,37,48,59],
	"dia_eleven" : [5,16,27,38,49],
	"dia_twelve" : [4,13,22,31,40],
	"dia_thirteen" : [5,14,23,32,41,50],
	"dia_fourteen" : [6,15,24,33,42,51,60],
	"dia_fifteen" : [7,16,25,34,43,52,61,70],
	"dia_sixteen" : [8,17,26,35,44,53,62,71,80],
	"dia_seventeen" : [9,18,27,36,45,54,63,72,81,90],
	"dia_eightteen" : [19,28,37,46,55,64,73,82,91],
	"dia_nineteen" : [29,38,47,56,65,74,83,92],
	"dia_twenty" : [39,48,57,66,75,84,93],
	"dia_twenty_one" : [49,58,67,76,85,94],
	"dia_twenty_two" : [59,68,77,86,95]
	
	
	
}
var possible_win_x = []
var possible_win_o = []
var data_store = []
var win =false
	
#function to get the main node
func get_main_node():
	var root = get_tree().get_root()
	return root.get_child(root.get_child_count() - 1)

func _ready():
	reset_data_store()
	pass

func reset_data_store():
	win = false
	for i in range(0,2000):
		data_store.append("--")



func get_keys_for_value(value):
	var all_keys = checker_dict.keys()
	var keys = []
	for i in range(0, all_keys.size()):
		var values = checker_dict[String(all_keys[i])]
		for j in range(0, values.size()):
			if(values[j] == value):
				keys.append(String(all_keys[i]))
	return keys



func check_win(pos, letter):
	var tally = 0
	var key = []
	var keys_to_check = get_keys_for_value(pos)
	
	#check if win occured on all this keys
	for i in range(0, keys_to_check.size()):
		key = keys_to_check[i]
		for j in range(0, checker_dict[key].size()):
			if(data_store[checker_dict[key][j]] == letter):
				tally +=1
				
		if(tally == 5):
			win = true
			break
		elif(tally == 3):
			if(letter == "x"):
				possible_win_x.append(key)
			else:
				possible_win_o.append(key)
			tally = 0
		else:
			tally = 0
			
	if(win):
		won_game(checker_dict[key])


func won_game(win_key):
	var inst = game_won.instance()
	var node = "POS" + String(win_key[4])
	inst.position = get_main_node().get_node("Grid//" + node).global_position
	var diff = win_key[4] - win_key[0]
	match diff:
		36:
			inst. rotation = deg2rad(-45)
		44:
			inst. rotation = deg2rad(45)
		40:
			inst. rotation = deg2rad(90)
	
	get_main_node().add_child(inst)


func play_winning_move():
	var played_winning_move = false
	var played_pos = -1
	var key_to_remove = -1        #sometimes once possible wins are stored, that possition might be taken by other player and no longer useful
	
	  #all possible win outcomes are stored in possible_win_o array.
	if(possible_win_o.size() > 0):
		#this means there is a winning possibility
		for i in range(0, possible_win_o.size()):
			#go through all those possibilities
			for j in range(0, checker_dict[possible_win_o[i]].size()):
				#go through all the positions in those possibilities
				if(data_store[checker_dict[possible_win_o[i]][j]] == "--"):
					#if a possition is empty
					played_pos = checker_dict[possible_win_o[i]][j]    #that should be the position to play
					key_to_remove = i
					#now lets find that node for that particular pos to play
					var node = "POS" + String(played_pos)
					get_main_node().get_node("Grid/" + node).play_o()
					played_winning_move = true
					
				if(played_winning_move):
					return played_winning_move
					
		if(key_to_remove != -1):
			possible_win_o.remove(key_to_remove)
		else:
			possible_win_o = []
			
	return played_winning_move       #in case it's false


func block_players_win():
	#same as play_winning_move() but concers the winning possibilites of x, i.e., possible_win_x array
	var blocked_player = false
	var played_pos = -1
	var key_to_remove = -1        #sometimes once possible wins are stored, that possition might be taken by other player and no longer useful
	
	  #all possible win outcomes are stored in possible_win_o array.
	if(possible_win_x.size() > 0):
		#this means there is a winning possibility
		for i in range(0, possible_win_x.size()):
			#go through all those possibilities
			for j in range(0, checker_dict[possible_win_x[i]].size()):
				#go through all the positions in those possibilities
				if(data_store[checker_dict[possible_win_x[i]][j]] == "--"):
					#if a possition is empty
					played_pos = checker_dict[possible_win_x[i]][j]    #that should be the position to play
					key_to_remove = i
					#now lets find that node for that particular pos to play
					var node = "POS" + String(played_pos)
					get_main_node().get_node("Grid/" + node).play_o()
					blocked_player = true
					
				if(blocked_player):
					return blocked_player
					
		if(key_to_remove != -1):
			possible_win_x.remove(key_to_remove)
		else:
			possible_win_x = []
			
	return blocked_player      #in case it's false


func check_for_draw():
	var draw = true
	for i in range(0, data_store.size()):
		if(data_store[i] == "--"):
			draw = false     #if one of them is empty, it's not draw
	return draw

func play_computer():
	var won_by_comp = play_winning_move()                #first priority
	if(won_by_comp):
		return                                    #game end
	
	var blocked_players_win = block_players_win()                #second
	if(blocked_players_win):
		return                          #no other move needed


	var draw = check_for_draw()                   #third
	if(draw):
		return                     #it's like stalemate. Nothing to do 

	#if nothing, take a random pos and play
	var can_take_pos = false    #boolean to check if that particular position can be taken
	while(!can_take_pos):
		#as long as that position cannot be taken we need another random pos
		var pos = randi()%99
		if(data_store[pos] == "--"):
			can_take_pos = true
			var node = "POS" + String(pos)
			get_main_node().get_node("Grid/" + node).play_o()

func _process(delta):
	if(Input.is_key_pressed(KEY_ENTER)):
		possible_win_o = []
		possible_win_x = []
		reset_data_store()
		get_tree().reload_current_scene()
		
		
	if(Input.is_action_just_pressed("ui_select")):    #for  testing press space
		play_computer()
