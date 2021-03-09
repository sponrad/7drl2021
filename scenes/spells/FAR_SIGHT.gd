extends Area2D

onready var game_manager : Node = get_node("/root/MainScene")

func _ready():
    game_manager.map.clear_fov_at_position(position, 3)

func _on_Timer_timeout():
    queue_free()
