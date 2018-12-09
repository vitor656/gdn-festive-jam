extends Node2D

var Laser = preload("res://Itens/Laser/Laser.tscn")
var isShooting = false

const SPAWNING_INTERVAL = 1
var spawningIntervalTimer = 0

func _ready():
	$WaitTimer.start()

func _process(delta):
	spawningIntervalTimer -= 1
	
	if isShooting && spawningIntervalTimer <= 0:
		shootLaser()
	
	if spawningIntervalTimer <= 0:
		spawningIntervalTimer = SPAWNING_INTERVAL 

func shootLaser():
	var newLaser = Laser.instance()
	add_child(newLaser)

func _on_WaitTimer_timeout():
	isShooting = true
	$ShootingTimer.start()


func _on_ShootingTimer_timeout():
	isShooting = false
	$WaitTimer.start()
