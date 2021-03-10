extends Area2D

onready var game_manager : Node = get_node("/root/MainScene")

func _ready():
    game_manager.win()

func _on_Timer_timeout():
    queue_free()
