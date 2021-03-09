extends Area2D

var known_spells: Array = []
var is_casting = false
onready var game_manager : Node = get_node("/root/MainScene")

func _ready():
    z_index = 0
    known_spells = [
        SpellData.spells.ENCHANT_AREA,
        SpellData.spells.FAR_SIGHT,
        SpellData.spells.MAGIC_SPIRIT,
        SpellData.spells.FIRE_BOLT,
        SpellData.spells.CRAB,
    ]

func _process(delta):
    if is_casting:
        $CastingSwirl.rotate(delta * 1.5)

func set_casting(casting):
    is_casting = casting
    if casting:
        $CastingSwirl.show()
    else:
        $CastingSwirl.hide()


func take_damage(amount):
    Globals.show_damage((position + Vector2(-16, -16)), amount)
    game_manager.game_over()
