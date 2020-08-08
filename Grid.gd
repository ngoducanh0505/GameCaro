extends Node2D


export (int) var width;
export (int) var height;
export (int) var x_start;
export (int) var y_start;
export (int) var offset;


var game_array = [];

func _ready():
	game_array = make_array();
	print(game_array);


func make_array():
	var array = [];
	for  i in width:
		array.append([]);
		for j in height:
			array[i].append(null);
	return array;

