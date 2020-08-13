extends Node2D

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
	"dia_12" : [4,13,22,31,40]
	
	
}

var data_store = []
var win =false
	

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
		else:
			tally = 0
			
	if(win):
		print("won")

func _process(delta):
	if(Input.is_key_pressed(KEY_ENTER)):
		get_tree().reload_current_scene()
		reset_data_store()

