extends Camera2D

onready var player = get_parent().get_node("Player")

var x_resolution
var y_resolution

func _ready():
	x_resolution = get_viewport_rect().size.x
	y_resolution = get_viewport_rect().size.y

func _physics_process(delta):
	var next_x = floor(player.position.x / x_resolution) * x_resolution
	var next_y = floor(player.position.y / y_resolution) * y_resolution
	
	position.x = lerp(position.x, next_x, 0.5)
	position.y = lerp(position.y, next_y, 0.5)