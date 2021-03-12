extends Area2D

var known_spells: Array = []
var discovered_spells: Array = []
var is_casting = false
var barrier
onready var game_manager : Node = get_node("/root/MainScene")
var testing = false
var current_message

func _ready():
    z_index = -1
    known_spells = [
        SpellData.spells.CLEAR_FOG,
        SpellData.spells.TELEPORT_ITEM,
        SpellData.spells.MAGIC_SPIRIT,
        SpellData.spells.FIRE_BOLT,
    ]
    if testing:
        known_spells = SpellData.spells.values()
        game_manager.current_mana = 10000

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
    if barrier:
        barrier.queue_free()
        barrier = null
        return
    Globals.show_damage((position + Vector2(-16, -16)), amount)
    game_manager.game_over()

func show_message(message):
    if not current_message:
        current_message = Globals.OverheadMessage.instance()
        add_child(current_message)
    current_message.add_message(message)
