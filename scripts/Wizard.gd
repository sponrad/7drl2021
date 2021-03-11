extends Area2D

var known_spells: Array = []
var discovered_spells: Array = []
var is_casting = false
var barrier
onready var game_manager : Node = get_node("/root/MainScene")

func _ready():
    z_index = 0
    known_spells = [
        #SpellData.spells.ENCHANT_AREA,
        #SpellData.spells.FAR_SIGHT,
        SpellData.spells.MAGIC_SPIRIT,
        SpellData.spells.FIRE_BOLT,
        #SpellData.spells.SPELL_OF_MASTERY,
        #SpellData.spells.LIGHTNING
    ]
    # start with some learnable spells
    #discovered_spells.append(ItemData.find_unique_spell(self))
    #discovered_spells.append(ItemData.find_unique_spell(self))

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
    print("showing message %s" % message)
    var status_message = Globals.OverheadMessage.instance()
    status_message.set_text(message)
    add_child(status_message)
