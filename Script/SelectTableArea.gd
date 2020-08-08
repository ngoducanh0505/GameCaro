extends Area2D

onready var x = preload("res://xicon.png")
onready var o = preload("res://oIcon.png")

var selected = false

func _ready():
	$mouse_over.hide()

func _on_POS_mouse_entered():
	if(!selected):
		$mouse_over.show()


func _on_POS_mouse_exited():
	$mouse_over.hide()
	
func play_x():
	if(!selected):
		$x_o.set_texture(x)
		
func play_o():
	if(!selected):
		$x_o.set_texture(o)




func _on_POS_input_event(viewport, event, shape_idx):
	if(event is InputEventMouseButton):
		if(event.button_index == BUTTON_LEFT):
			play_x()
			$mouse_over.hide()
			selected = true
		else:
			play_o()
			$mouse_over.hide()
			selected = true
