extends Area2D

onready var game_manager : Node = get_node("/root/MainScene")
var spell = SpellData.spells.BARRIER
var total_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
    game_manager.get_node('Wizard').barrier = self

func _process(delta):
    total_time += delta
    $Sprite.modulate.a = abs(sin(total_time)) * 0.4
